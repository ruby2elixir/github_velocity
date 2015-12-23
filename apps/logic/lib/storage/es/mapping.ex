defmodule Storage.Es.Mapping do
  def config do
    %{
      "mappings": %{
        "issue": %{
          "properties": %{
            "path": %{
              "type": "string",
              "index": "not_analyzed"
            },
            "title": %{
              "type": "string"
            },
            "status": %{
              "type": "string",
              "index": "not_analyzed"
            },
            "opened_at": %{
              "type": "date",
            },
            "opened_by": %{
              "type": "string",
              "index": "not_analyzed"
            },
            "closed_at": %{
              "type": "date",
            },
            "closed_by": %{
              "type": "string",
              "index": "not_analyzed"
            },
            "last_activity_at": %{
              "type": "date",
            },
            "last_activity_by": %{
              "type": "string",
              "index": "not_analyzed"
            },
            "number_of_comments": %{
              "type": "integer"
            },
            "number_of_participants": %{
              "type": "integer"
            },
            "labels": %{
              "type": "string",
              "index": "not_analyzed"
            }
          }
        }
      }
    }
  end
end
