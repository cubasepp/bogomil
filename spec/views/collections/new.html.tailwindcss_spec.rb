# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/new", type: :view) do
  before(:each) do
    assign(:collection, FactoryBot.build(:collection))
  end

  it_behaves_like "a default card"
  include_examples "a turbo_frame", "wrapper_collection"
  include_examples "a turbo_frame", "new_collection"

  it "renders new collection form" do
    render

    assert_select "form[action=?][method=?][id=?]", collections_path, "post", "new_collection" do
      assert_select "input[name=?]", "collection[name]"
      assert_select "a[href=?][data-turbo-frame=?]", collections_path, "wrapper_collection"
    end
  end
end
