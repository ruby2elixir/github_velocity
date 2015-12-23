defmodule Logic.IssueListParserTest do
  use ExSpec, async: true
  alias Logic.IssueListParser

  describe "Parser" do

    describe "returns the parsed issues on page" do
      @result "issue_lists/rails_page_1.html" |> TestHelper.fixture |> IssueListParser.parse

      it "works" do
        assert @result |> Enum.count == 25
      end
    end
  end
end
