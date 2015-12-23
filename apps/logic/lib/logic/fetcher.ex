defmodule Logic.Fetcher do
  def fetch(project)  do
    fetch(project, 1)
  end

  def fetch(project, pagenum)  do
    url(project, pagenum)
      |> HTTPotion.get
      |> Map.get(:body)
      |> Logic.IssueListParser.parse
  end

  def url(project, page) do
    # https://github.com/elixir-lang/elixir/issues?page=1&q=is%3Aissue+sort%3Aupdated-desc
    "https://github.com/#{project}/issues?page=#{page}&q=is%3Aissue+sort%3Aupdated-desc"
  end
end
