# frozen_string_literal: true

require "rails_helper"

RSpec.describe("calculators/_result_stat", type: :view) do
  it "renders the result_stat partial" do
    render locals: { percent: 1, percentage_points: 2 }

    assert_select "div[class=?][id=?]", "stat", "result_stat", count: 1 do
      assert_select "div[class=?]", "stat-title", text: "Percent", count: 1
      assert_select "div[class=?]", "stat-value text-primary", text: "1", count: 1
      assert_select "div[class=?]", "stat-desc text-secondary pt-2", text: /Percentage points/, count: 1
    end
  end
end
