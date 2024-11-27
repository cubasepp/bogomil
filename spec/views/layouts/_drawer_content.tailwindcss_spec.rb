# frozen_string_literal: true

require "rails_helper"

RSpec.describe("layouts/_drawer_content", type: :view) do
  before(:each) do
    view.define_singleton_method(:signed_in?) do
      true
    end
  end

  it "renders the drawer" do
    render

    assert_select "div[id=?]", "header", count: 1
    assert_select "div[class=?]", "drawer-content", count: 1 do
      assert_select "div[class=?]", "max-h-screen px-6 pb-16 xl:pr-2", count: 1 do
        assert_select "div[class=?]",
          "flex flex-col-reverse justify-between gap-6 xl:flex-row",
          count: 1 do
          assert_select "div[class=?]",
            "max-w-4xl min-w-96 flex-grow p-4 bg-base-300 shadow-xl rounded-lg",
            count: 1
        end
      end
    end
  end
end
