defmodule Logic.IssueItemParserTest do
  use ExSpec, async: true
  alias Logic.IssueItemParser

  describe "Parser" do

    describe "closed issue" do
      @result "issues/rails_12537.html" |> TestHelper.fixture |> IssueItemParser.parse

      it "is parsed to proper structs" do
        assert @result.id  == "12537"
        assert @result.opened_at  == "2013-10-14T19:35:50Z"
        assert @result.opened_by  == "njakobsen"
        assert @result.title  == "Major performance regression when preloading has_many_through association"
        assert @result.path  == "/rails/rails/issues/12537"
        assert @result.status  == "closed"
        assert @result.number_of_comments == 5
      end

      it "has right closing data" do
        assert @result.closed_by  == "tenderlove"
        assert @result.closed_at  == "2015-12-19T02:46:15Z"
      end

      it "has last activity data" do
        assert @result.last_activity_at  == "2015-12-19T02:46:15Z"
        assert @result.last_activity_by  == "tenderlove"
      end
    end


    describe "open issue" do
      @result "issues/rails_19084.html" |> TestHelper.fixture |> IssueItemParser.parse

      it "is parsed to proper structs" do
        assert @result.id  == "19084"
        assert @result.status  == "open"
        assert @result.path  == "/rails/rails/issues/19084"
        assert @result.opened_at  == "2015-02-26T01:15:31Z"
        assert @result.opened_by  == "sbull"
        assert @result.title  == "Thread bug with Rails::Engine mounted routes, undefined method `url_options'"
        assert @result.number_of_comments == 9
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

    describe "labels" do
      it "works with present labels" do
        res = "issues/rails_19084.html" |> TestHelper.fixture |> IssueItemParser.parse
        assert res.labels == ["actionpack", "engines", "With reproduction steps"]
      end

      it "works without labels" do
        res = "issues/rails_19332.html" |> TestHelper.fixture |> IssueItemParser.parse
        assert res.labels == []
      end
    end

    describe "participants" do
      it "works" do
        res = "issues/rails_19084.html" |> TestHelper.fixture |> IssueItemParser.parse
        assert res.participants == ["sbull", "evanphx", "jvanbaarsen", "rafaelfranca", "ahacop", "dlackty", "robin850"]
        assert res.number_of_participants == 7
      end

      it "works 2.nd example" do
        res = "issues/rails_19332.html" |> TestHelper.fixture |> IssueItemParser.parse
        assert res.participants == ["halorgium", "matthewd", "tarcieri", "spscream", "TiagoCardoso1983"]
        assert res.number_of_participants == 5
      end
    end

    describe "get_current_time" do
      it "works" do
        res = "issues/rails_19332.html" |> TestHelper.fixture |> IssueItemParser.parse
        refute res.updated_at == ""
        assert res.updated_at =~  Regex.compile("#{Timex.Date.now.year}") |> Prelude.ok
      end
    end
  end


end
