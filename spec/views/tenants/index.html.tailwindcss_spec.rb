# frozen_string_literal: true

require "rails_helper"

RSpec.describe("tenants/index", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end
  let(:living_unit) do
    FactoryBot.build_stubbed(:living_unit, id: 1)
  end

  let(:tenants) do
    FactoryBot.build_stubbed_list(:tenant, 2) do |rent, id|
      rent.id = id + 1
    end
  end

  before(:each) do
    assign(:living_unit, living_unit)
    assign(:real_estate, real_estate)
    assign(:tenants, tenants)
  end

  include_examples "a main turbo_frame", "tenants"

  it "renders index tenants" do
    render

    assert_select "div[role=?]", "tablist", count: 1 do
      assert_select "a[role=?]", "tab", count: 3

      assert_select "a[href=?]", new_living_unit_tenant_path(living_unit), count: 1
      assert_select "table[class=?]", "table table-zebra" do
        assert_select "thead", count: 1 do
          assert_select "tr", count: 1 do
            assert_select "th", count: 6
          end
        end
        assert_select "tbody", count: 1 do
          assert_select "tr[id=?]", "tenant_1", count: 1 do
            assert_select "th", count: 1
            assert_select "td", count: 5
          end
          assert_select "tr[id=?]", "tenant_2", count: 1 do
            assert_select "th", count: 1
            assert_select "td", count: 5
          end
        end
      end
    end
  end
end
