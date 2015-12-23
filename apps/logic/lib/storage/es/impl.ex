defmodule Storage.Es.Impl do
  #alias Elastix.Index
  alias Storage.Es.Index
  alias Elastix.Document

  @es_url    "http://localhost:9200"
  @es_index  "issues"

  def store(issue_item) do
    Document.index(@es_url, @es_index, "issue", issue_item.id, issue_item)
  end

  def get(issue_item) do
    Document.get @es_url, @es_index, "issue", issue_item.id
  end

  def exists?(issue_item) do
    Document.exists? @es_url, @es_index, "issue", issue_item.id
  end

  def ensure_index_present do
    Elastix.start()
    unless Index.exists?(@es_url, @es_index) do
      Index.create(@es_url, @es_index, Storage.Es.Mapping.config)
      Index.refresh(@es_url, @es_index)
    end
  end

end
