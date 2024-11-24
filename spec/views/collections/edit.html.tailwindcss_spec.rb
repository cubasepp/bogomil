# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/edit", type: :view) do
  let(:collection) do
    FactoryBot.build_stubbed(:collection, id: 1)
  end

  before(:each) do
    assign(:collection, collection)
  end

  it_behaves_like "a default card"
  include_examples "a main turbo_frame", "collection_1"

  it "renders edit collection form" do
    render

    assert_select "form[action=?][method=?][id=?]", collection_path(1), "post", "edit_collection_1" do
      assert_select "input[name=?]", "collection[name]"
      assert_select "a[href=?][data-turbo-frame=?]", collection_path(1), "main_content"
    end
  end
end
