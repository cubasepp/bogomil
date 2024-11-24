# frozen_string_literal: true

require "rails_helper"

RSpec.describe("layouts/drawer/_quick_menu", type: :view) do
  before(:each) do
  end

  it "renders the quick_menu" do
    render

    assert_select "a[href=?][data-turbo-frame=?]", new_collection_path, "main_content", count: 1
  end
end
