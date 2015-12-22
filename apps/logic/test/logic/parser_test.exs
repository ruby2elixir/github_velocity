defmodule Logic.IssueItemParserTest do
  use ExSpec, async: true
  alias Logic.IssueItemParser

  describe "Parser" do

    describe "closed issue" do
      @result "issue_rails_12537.html" |> TestHelper.fixture |> IssueItemParser.parse

      it "is parsed to proper structs" do
        assert @result.id  == "12537"
        assert @result.opened_at  == "2013-10-14T19:35:50Z"
        assert @result.opened_by  == "njakobsen"
        assert @result.title  == "Major performance regression when preloading has_many_through association"
        assert @result.path  == "/rails/rails/issues/12537"
        assert @result.status  == "Closed"

      end

      it "has right closing data" do
        assert @result.closed_by  == "tenderlove"
        assert @result.closed_at  == "2015-12-19T02:46:15Z"
      end

      # it "has last activity data" do
      #   assert @result.last_activity_at  == "2015-12-19T02:46:15Z"
      #   assert @result.last_activity_by  == "tenderlove"
      # end
    end


    describe "open issue" do
      @result "issue_rails_19084.html" |> TestHelper.fixture |> IssueItemParser.parse

      it "is parsed to proper structs" do
        assert @result.id  == "19084"
        assert @result.status  == "Open"
        assert @result.path  == "/rails/rails/issues/19084"
        assert @result.opened_at  == "2015-02-26T01:15:31Z"
        assert @result.opened_by  == "sbull"
        assert @result.title  == "Thread bug with Rails::Engine mounted routes, undefined method `url_options'"
      end

      it "has no closing data" do
        assert @result.closed_by  == ""
        assert @result.closed_at  == ""
      end

      it "has last activity data" do
        assert @result.last_activity_by  == "dlackty"
        assert @result.last_activity_at  == "2015-12-17T07:26:18Z"
      end
    end

  end
end
