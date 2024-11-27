# frozen_string_literal: true

require "rails_helper"

RSpec.describe("calculators/_result", type: :view) do
  it "renders the result partial" do
    render locals: { frames: [:new_index] }

    assert_select "turbo-frame[id=?]", "result", count: 1 do
      assert_select "div[class=?][data-controller=?][data-action=?]",
        "stats stats-vertical shadow",
        "calculator",
        "calculator:selection@document->calculator#onSelection",
        count: 1 do
          assert_select "div[class=?]", "stat", count: 2
          assert_select "div[id=?]", "result_stat", count: 1
        end
    end
  end
end
