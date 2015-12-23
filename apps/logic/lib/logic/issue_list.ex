defmodule Logic.IssueList do
  @derive [Poison.Encoder]
  defstruct pagenum: "",
    path: "",
    issues: [],
    total_pages: 0

end

defmodule Logic.IssueListItem do
  @derive [Poison.Encoder]
  defstruct id: "",
    path: "",
    status: "",
    opened_by: "",
    opened_at: ""
end
