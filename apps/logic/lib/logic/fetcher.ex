defmodule Logic.Fetcher do
  def fetch(project)  do
    fetch(project, 1)
  end

  def fetch(project, pagenum)  do
    uri = url(project, pagenum)
    HTTPotion.get uri
  end

  def url(project, page) do
    # https://github.com/elixir-lang/elixir/issues?page=1&q=is%3Aissue+sort%3Aupdated-desc
    "https://github.com/#{project}/issues?page=#{page}&q=is%3Aissue+sort%3Aupdated-desc"
  end
end
