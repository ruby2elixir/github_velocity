defmodule Logic.Fetcher do
  def fetch(project)  do
    fetch_issue_list(project, 1)
  end

  def fetch_issue_list(project, page)  do
    issue_list_url(project, page)
      |> HTTPotion.get
      |> Map.get(:body)
      |> Logic.IssueListParser.parse
  end


  def fetch_issue(project, id) do
    issue_url(project, id)
      |> HTTPotion.get
      |> Map.get(:body)
      |> Logic.IssueItemParser.parse
  end

  def issue_list_url(project, page) do
    "https://github.com/#{project}/issues?page=#{page}&q=is%3Aissue+sort%3Aupdated-desc"
  end

  def issue_url(project, id) do
    "https://github.com/#{project}/issues/#{id}"
  end
end
