defmodule Logic.Storage do
  def store(issue_item) do
    Storage.Es.Impl.store(issue_item)
  end

  def get(issue_item) do
    Storage.Es.Impl.get(issue_item)
  end

  def exists?(issue_item) do
    Storage.Es.Impl.exists?(issue_item)
  end
end
