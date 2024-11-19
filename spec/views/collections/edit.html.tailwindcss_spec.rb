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

  it "renders edit collection form" do
    render
    assert_select "form[action=?][method=?][data-turbo=?]", collection_path(collection), "post", "false" do
      assert_select "input[name=?]", "collection[name]"
    end
  end
end
