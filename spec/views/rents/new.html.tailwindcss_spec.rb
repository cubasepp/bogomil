# frozen_string_literal: true

require "rails_helper"

RSpec.describe("rents/new", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end
  let(:living_unit) do
    FactoryBot.build_stubbed(:living_unit, id: 1)
  end

  let(:rent) do
    FactoryBot.build(:rent)
  end

  before(:each) do
    assign(:living_unit, living_unit)
    assign(:real_estate, real_estate)
    assign(:rent, rent)
  end

  include_examples "a main turbo_frame", "rents"

  it "renders the new page" do
    render
    assert_select "div[role=?]", "tablist", count: 1 do
      assert_select "a[role=?]", "tab", count: 3
      assert_select "form[action=?][method=?][id=?]",
        living_unit_rents_path(1),
        "post",
        "new_rent" do
          assert_select "input[name=?][type=?]", "rent[cold_rent]", "number"
          assert_select "input[name=?][type=?]", "rent[heating_costs]", "number"
          assert_select "input[name=?][type=?]", "rent[incidental_costs]", "number"
          assert_select "select[name=?]", "rent[rent_type]"
          assert_select "select[name=?]", "rent[valid_from(1i)]"
          assert_select "select[name=?]", "rent[valid_from(3i)]"
          assert_select "select[name=?]", "rent[valid_from(3i)]"
        end
    end
  end
end
