defmodule Logic.IssueListParserTest do
  use ExSpec, async: true
  alias Logic.IssueListParser

  describe "Parser" do

    describe "returns the parsed issues on page" do
      @result "issue_lists/rails_page_1.html" |> TestHelper.fixture |> IssueListParser.parse

      it "has right count" do
        assert @result.issues |> Enum.count == 25
        assert @result.pagenum == 1
        assert @result.total_pages == 319
      end

      it "parses the right data" do
        elem = @result.issues |> Enum.at(0)
        assert elem.id == "22765"
        assert elem.path == "/rails/rails/issues/22765"
        assert elem.status == "closed"
      end
    end
  end
end
