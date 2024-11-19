# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/new", type: :view) do
  before(:each) do
    assign(:collection, FactoryBot.build(:collection))
  end

  it_behaves_like "a default card"

  it "renders new collection form" do
    render

    assert_select "form[action=?][method=?][data-turbo=?]", collections_path, "post", "false" do
      assert_select "input[name=?]", "collection[name]"
    end
  end
end
