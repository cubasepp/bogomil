# frozen_string_literal: true

require "rails_helper"

RSpec.describe("calculators/_form", type: :view) do
  it "renders the form partial" do
    render locals: {
      turbo_frame: "new_index", incomplete_years: "[]", start_year: 2024, end_year: 2022,
    }

    assert_select "div[data-calculator-selection-setting-value=?]", "[]", count: 1
    assert_select "div[data-calculator-selection-frame-id-value=?]", "newIndex", count: 1
    assert_select "div[data-controller=?]", "calculator-selection", count: 1 do
      assert_select "h2", count: 1
      assert_select "select[id=?][data-calculator-selection-target=?][data-action=?]",
        "date_year",
        "year",
        "calculator-selection#selectYear",
        count: 1
      assert_select "select[id=?][data-calculator-selection-target=?][data-action=?]",
        "date_month",
        "month",
        "calculator-selection#selectMonth",
        count: 1
    end
  end
end
