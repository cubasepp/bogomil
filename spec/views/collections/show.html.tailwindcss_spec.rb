# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/show", type: :view) do
  let(:collection) do
    FactoryBot.build_stubbed(:collection, id: 1)
  end

  before(:each) do
    assign(:collection, collection)
  end

  it_behaves_like "a default card", 1

  it "renders the show page" do
    render
    assert_select "a[href=?]", edit_collection_path(1), count: 1
    assert_select "a[href=?][data-turbo-method=?]", collection_path(1), "delete", count: 1
  end
end
