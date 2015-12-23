defmodule Worker.IssuesListWorker do
  def perform(project, pagenum) do
    Logic.Fetcher.fetch(project, pagenum)
    IO.puts "performed #{project} on #{pagenum}"
  end
end
