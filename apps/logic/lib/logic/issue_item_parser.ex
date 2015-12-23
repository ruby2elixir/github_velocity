defmodule Logic.IssueItemParser do
  use Logic.Util.Parser
  def parse(issue_html) do
    issue_doc = Floki.find(issue_html, ".main-content")
    item      = %Logic.IssueItem{}
    item = item
      |> Map.put(:id,                          get_id(issue_doc))
      |> Map.put(:status,                      get_status(issue_doc))
      |> Map.put(:title,                       get_title(issue_doc))
      |> Map.put(:path,                        get_path(issue_doc))
      |> Map.put(:opened_at,                   get_opened_at(issue_doc))
      |> Map.put(:opened_by,                   get_opened_by(issue_doc))
      |> Map.put(:last_activity_at,            get_last_activity_at(issue_doc))
      |> Map.put(:last_activity_by,            get_last_activity_by(issue_doc))
      |> Map.put(:labels,                      get_labels(issue_doc))
      |> Map.put(:participants,                get_participants(issue_doc))
      |> Map.put(:number_of_participants,      get_number_of_participants(issue_doc))
      |> Map.put(:number_of_comments,          get_number_of_comments(issue_doc))
      |> Map.put(:updated_at,                  get_current_time)

    case item.status  do
       "closed" -> item |> parse_closed_data(issue_doc)
       _ -> item
    end
  end

  def parse_closed_data(item, issue_doc) do
    item
      |> Map.put(:closed_by,      get_closed_by(issue_doc))
      |> Map.put(:closed_at,      get_closed_at(issue_doc))
  end

  def get_id(issue_doc) do
    issue_doc
      |> Floki.find(".gh-header-number")
      |> Floki.text
      |> String.replace("#", "")
  end

  def get_title(issue_doc) do
    issue_doc
     |> Floki.find(".js-issue-title")
     |> Floki.text
  end


  def get_opened_at(issue_doc) do
     issue_doc
     |> Floki.find(".js-comment-container")
     |> Enum.at(0)
     |> find_datevalue
  end

  def get_opened_by(issue_doc) do
    issue_doc
     |> Floki.find(".js-comment-container")
     |> Enum.at(0)
     |> find_author
  end

  def get_path(issue_doc) do
    issue_doc
      |> Floki.find("#partial-discussion-sidebar")
      |> find_in_attrs("data-url")
      |> String.replace("/show_partial?partial=issues%2Fsidebar", "")
  end

  def get_status(issue_doc) do
    issue_doc
      |> Floki.find(".gh-header-meta .flex-table-item")
      |> Enum.at(0)
      |> Floki.text
      |> String.strip
      |> String.downcase
  end

  def get_closed_by(issue_doc) do
    issue_doc
      |> Floki.find(".discussion-item-closed")
      |> last
      |> find_author
  end

  def get_closed_at(issue_doc) do
    issue_doc
      |> Floki.find(".discussion-item-closed")
      |> last
      |> find_datevalue
  end

  def get_last_activity_at(issue_doc) do
    issue_doc
      |> get_last_action
      |> find_datevalue
  end

  def get_last_activity_by(issue_doc) do
    issue_doc
      |> get_last_action
      |> find_author
  end

  def get_last_action(issue_doc) do
    # "#partial-timeline-marker" is the last element after all activities
    # we check wether it has got a comment sibling, if not, we asume the closed item was last activity
    case Floki.find(issue_doc, ".js-comment-container + #partial-timeline-marker") do
      [] ->
        issue_doc
        |> Floki.find(".discussion-item-closed")
      _  ->
        issue_doc
        |> Floki.find(".js-comment-container")
        |> last
    end
  end


  def get_labels(issue_doc) do
    issue_doc
      |> Floki.find(".labels a.label")
      |> Enum.map( fn(a) -> Floki.text(a) end)
  end

  def get_participants(issue_doc) do
    issue_doc
      |> Floki.find(".participation .participation-avatars .participant-avatar")
      |> Enum.map( fn(a) -> find_in_attrs(a, "aria-label") end)
  end

  def get_number_of_participants(issue_doc) do
    issue_doc |> get_participants |> Enum.count
  end

  def get_number_of_comments(issue_doc) do
    s = issue_doc
      |> Floki.find(".gh-header-meta .flex-table-item-primary")
      |> Floki.text

    Regex.run(~r/(\d+) (comment|comments)/, s) |> Enum.at(1) |> String.to_integer
  end
end
