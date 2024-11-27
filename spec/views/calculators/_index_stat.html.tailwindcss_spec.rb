# frozen_string_literal: true

require "rails_helper"

RSpec.describe("calculators/_index_stat", type: :view) do
  it "renders the index_stat partial" do
    render locals: { frame_id: "demo_id", title: "Demo" }

    assert_select "div[class=?]", "stat", count: 1 do
      assert_select "div[class=?]", "stat-title", text: "Demo", count: 1
      assert_select "div[class=?]", "stat-value text-primary", count: 1 do
        assert_select "turbo-frame[id=?][data-calculator-target=?]", "demo_id", "demoId", count: 1
      end
    end
  end
end
