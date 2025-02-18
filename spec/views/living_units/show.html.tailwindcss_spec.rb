# frozen_string_literal: true

require "rails_helper"

RSpec.describe("living_units/show", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end
  let(:living_unit) do
    FactoryBot.build_stubbed(:living_unit, id: 1)
  end

  before(:each) do
    assign(:living_unit, living_unit)
    assign(:real_estate, real_estate)
  end

  include_examples "a main turbo_frame", "living_unit_1"

  it "renders the show page" do
    render
    assert_select "div[role=?]", "tablist", count: 1 do
      assert_select "a[role=?]", "tab", count: 2
      assert_select "form[action=?][method=?][id=?]",
        real_estate_living_unit_path(1, 1),
        "post",
        "edit_living_unit_1" do
          assert_select "input[name=?][disabled=?]", "living_unit[name]", "disabled"
          assert_select "textarea[name=?][disabled=?]", "living_unit[description]", "disabled"
          assert_select "input[name=?][disabled=?]", "living_unit[rooms]", "disabled"
          assert_select "input[name=?][disabled=?]", "living_unit[living_space]", "disabled"
          assert_select "input[name=?][disabled=?]", "living_unit[own_use]", "disabled"
        end
    end
  end
end
