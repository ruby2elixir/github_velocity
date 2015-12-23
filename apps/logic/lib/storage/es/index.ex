# copy from Elastix with custom changes, may push upstream later...
# + bulk
# + refresh
defmodule Storage.Es.Index do
  @moduledoc """
  """
  alias Elastix.HTTP

  @doc false
  def create(elastic_url, name, data) do
    elastic_url <> make_path(name)
    |> HTTP.post(Poison.encode!(data))
    |> process_response
  end

  @doc false
  def delete(elastic_url, name) do
    elastic_url <> make_path(name)
    |> HTTP.delete
    |> process_response
  end

  @doc false
  def get(elastic_url, name) do
    elastic_url <> make_path(name)
    |> HTTP.get
    |> process_response
  end


  def bulk(elastic_url, name, data) do
    elastic_url <> make_path(name)
    |> make_path("_bulk")
    |> HTTP.post(data)
    |> process_response
  end

  @doc false
  def exists?(elastic_url, name) do
    request = elastic_url <> make_path(name)
      |> HTTP.head
      |> process_response

    case request.status_code do
      200 -> true
      404 -> false
    end
  end

  @doc false
  def refresh(elastic_url, name) do
    elastic_url <> make_path(name, "_refresh")
      |> HTTP.post("")
      |> process_response
  end

  @doc false
  def make_path(name) do
    "/#{name}"
  end

  def make_path(name, postfix) do
    "/#{name}/#{postfix}"
  end

  @doc false
  defp process_response({_, response}), do: response
end
