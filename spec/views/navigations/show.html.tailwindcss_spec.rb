# frozen_string_literal: true

require "rails_helper"

RSpec.describe("navigations/show", type: :view) do
  before(:each) do
    Current.user = FactoryBot.build(:user)
  end

  it "renders the navigation" do
    render

    assert_select "div.drawer-side", count: 1
    assert_select "div.wrapper_quick_menu", count: 1
    assert_select "div.wrapper_sidebar", count: 1
    assert_select "turbo-frame[id=?]", "quick_menu", count: 1
  end
end
