# frozen_string_literal: true

require "rails_helper"

RSpec.describe("tenants/new", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end
  let(:living_unit) do
    FactoryBot.build_stubbed(:living_unit, id: 1)
  end

  let(:tenant) do
    FactoryBot.build(:tenant)
  end

  before(:each) do
    assign(:living_unit, living_unit)
    assign(:real_estate, real_estate)
    assign(:tenant, tenant)
  end

  include_examples "a main turbo_frame", "tenants"

  it "renders the new page" do
    render
    assert_select "div[role=?]", "tablist", count: 1 do
      assert_select "a[role=?]", "tab", count: 3
      assert_select "form[action=?][method=?][id=?]",
        living_unit_tenants_path(1),
        "post",
        "new_tenant" do
          assert_select "input[name=?][type=?]", "tenant[first_name]", "text"
          assert_select "input[name=?][type=?]", "tenant[last_name]", "text"
          assert_select "input[name=?][type=?]", "tenant[email]", "email"
          assert_select "input[name=?][type=?]", "tenant[phone_number]", "tel"
        end
    end
  end
end
