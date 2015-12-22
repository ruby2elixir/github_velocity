ExUnit.start()


defmodule TestHelper do
  def fixture(file) do
    path           = Path.join(__DIR__, "fixtures/#{file}") |> Path.expand
    {:ok, content} = File.read(path)
    content
  end
end
