# frozen_string_literal: true

require "rails_helper"

RSpec.describe("layouts/drawer/_sidebar", type: :view) do
  before(:each) do
  end

  it "renders the sidebar" do
    render

    assert_select "turbo-cable-stream-source", count: 2
    assert_select "turbo-frame[id=?][src=?]", "sidebar", collections_path, count: 1
  end
end
