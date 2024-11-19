# frozen_string_literal: true

require "rails_helper"

RSpec.describe("navigations/_static_links", type: :view) do
  it "renders static links" do
    render

    assert_select "div[id=?]", "static_links", count: 1
    assert_select "ul>li", count: 2
  end
end
