defmodule Logic.IssueItem do
  @derive [Poison.Encoder]
  defstruct id: "",
    path: "",
    title: "",
    status: "",
    opened_at: "",
    opened_by: "",
    closed_at: "",
    closed_by: "",
    last_activity_at: "",
    last_activity_by: "",
    number_of_comments: 0,
    number_of_participants: 0,
    participants: [],
    labels: []
end
