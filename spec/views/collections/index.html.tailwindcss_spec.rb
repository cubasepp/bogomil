# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/index", type: :view) do
  before(:each) do
    assign(
      :collections,
      FactoryBot.build_stubbed_list(:collection, 2) do |collection, i|
        collection.id = i.next
      end,
    )
  end

  it "renders a list of collections" do
    render

    assert_select "tbody#collection_table_body", count: 1
    assert_select "tr[id=?]", "collection_1", count: 1
    assert_select "tr[id=?]", "collection_2", count: 1
  end

  it "renders a collection entry" do
    render

    assert_select "tr>td>a[href=?]", edit_collection_path(1), count: 1
    assert_select "tr>td>a[href=?]", collection_path(1), count: 1
    assert_select "tr>td>a[href=?][data-turbo-method=?]", collection_path(1), "delete", count: 1
  end
end
