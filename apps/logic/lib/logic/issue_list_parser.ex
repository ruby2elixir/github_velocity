defmodule Logic.IssueListParser do
  use Logic.Util.Parser

  def parse(issue_list_html) do
    issue_list_doc = Floki.find(issue_list_html, ".table-list")
    issue_items = Floki.find(issue_list_doc, ".js-issue-row") |> parse_issue_rows
  end


  def parse_issue_rows(elems) do
    elems |> Enum.map &parse_issue_row/1
  end

  def parse_issue_row(elem) do
    %{name: "a"}
  end
end
