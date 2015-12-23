defmodule Logic.Util do
  defmodule Parser do

    defmacro __using__(_opts) do
      quote location: :keep do
        defp find_author(elem) do
          elem
            |> Floki.find(".author")
            |> Floki.text
        end

        defp find_datevalue(elem) do
          elem
            |> Floki.find("time")
            |> find_in_attrs("datetime")
        end

        defp clean_integer(elem) do
          elem
            |> Floki.text
            |> String.strip
            |> String.to_integer
        end

        defp last(list) do
          list
            |> Enum.reverse
            |> Enum.at(0)
        end

        defp find_in_attrs(issue_doc, attr_type) do
          issue_doc
            |> Floki.attribute(attr_type)
            |> Enum.at(0)
        end

        def get_current_time do
          Timex.Date.now |> Timex.DateFormat.format("{ISOz}") |> Prelude.ok
        end

      end
    end
  end
end
