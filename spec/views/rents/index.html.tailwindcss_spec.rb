# frozen_string_literal: true

require "rails_helper"

RSpec.describe("rents/index", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end
  let(:living_unit) do
    FactoryBot.build_stubbed(:living_unit, id: 1)
  end

  let(:rents) do
    FactoryBot.build_stubbed_list(:rent, 2) do |rent, id|
      rent.id = id + 1
    end
  end

  before(:each) do
    assign(:living_unit, living_unit)
    assign(:real_estate, real_estate)
    assign(:rents, rents)
  end

  include_examples "a main turbo_frame", "rents"

  it "renders index rents" do
    render

    assert_select "div[role=?]", "tablist", count: 1 do
      assert_select "a[role=?]", "tab", count: 3

      assert_select "a[href=?]", new_living_unit_rent_path(living_unit), count: 1
      assert_select "table[class=?]", "table table-zebra" do
        assert_select "thead", count: 1 do
          assert_select "tr", count: 1 do
            assert_select "th", count: 8
          end
        end
        assert_select "tbody", count: 1 do
          assert_select "tr[id=?]", "rent_1", count: 1 do
            assert_select "th", count: 1
            assert_select "td", count: 7
          end
          assert_select "tr[id=?]", "rent_2", count: 1 do
            assert_select "th", count: 1
            assert_select "td", count: 7
          end
        end
      end
    end
  end
end
