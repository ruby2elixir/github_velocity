defmodule Logic.IssueListParser do
  #use Logic.Util.Parser

  def parse(issue_list_html) do
    issue_list_doc = Floki.find(issue_list_html, ".table-list")
    issue_items = Floki.find(issue_list_doc, ".js-issue-row") |> parse_issue_rows

    %Logic.IssueList{
      issues: issue_items
    }
  end


  def parse_issue_rows(elems) do
    elems |> Enum.map &parse_issue_row/1
  end

  def parse_issue_row(elem) do
    Logic.IssueListItemParser.parse(elem)
  end
end


defmodule Logic.IssueListItemParser do
  use Logic.Util.Parser
  def parse(elem) do
    %Logic.IssueListItem{}
      |> Map.put(:id,           get_id(elem))
      |> Map.put(:path,         get_path(elem))
      |> Map.put(:status,       get_status(elem))
  end

  def get_id(elem) do
    elem |> Floki.find(".issue-title-link")
    |> find_in_attrs("href")
    |> String.split("/issues/")
    |> Enum.at(1)
  end

  def get_status(elem) do
    case Floki.find(elem, ".octicon-issue-opened") do
      [] -> "closed"
      _ -> "open"
    end
  end

  def get_path(elem) do
    elem |> Floki.find(".issue-title-link") |> find_in_attrs("href")
  end
end
