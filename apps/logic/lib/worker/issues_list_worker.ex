defmodule Worker.IssuesListWorker do
  def perform(project, pagenum) do
    Logic.Fetcher.fetch(project, pagenum)
  end
end
