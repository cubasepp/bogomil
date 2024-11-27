# frozen_string_literal: true

require "rails_helper"

RSpec.describe("layouts/_drawer", type: :view) do
  it "renders the drawer" do
    render

    assert_select "label[for=?][class=?]",
      "main-drawer",
      "drawer-overlay",
      count: 1
    assert_select "div[class~=?]", "drawer-side", count: 1
    assert_select "div[id=?]", "wrapper_static_links", count: 1
    assert_select "div[id=?]", "wrapper_quick_menu", count: 1
    assert_select "div[id=?]", "wrapper_sidebar", count: 1
    assert_select "div[id=?]", "app_info", count: 1
  end
end
