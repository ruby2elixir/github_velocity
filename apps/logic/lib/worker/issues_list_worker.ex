defmodule Worker.IssuesListWorker do
  use Toniq.Worker, max_concurrency: 5

  def perform(project: project, page: page) do
    Logic.Fetcher.fetch(project, page)
    IO.puts "performed #{project} on #{page}"
  end
end
