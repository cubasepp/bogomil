# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/index", type: :view) do
  before(:each) do
    assign(
      :collections,
      FactoryBot.build_stubbed_list(:collection, 2) do |collection, id|
        collection.id = id + 1
      end,
    )
  end

  include_examples "a turbo_frame", "sidebar"

  it "renders the drawer" do
    render

    assert_select "ul[id=?]", "sidebar_list", count: 1 do
      assert_select "li[id=?]", "sidebar_collection_1", count: 1 do
        assert_select "div[id=?]", "name_collection_1", count: 1
      end
    end
  end
end
