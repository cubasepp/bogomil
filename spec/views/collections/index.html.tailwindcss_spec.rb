# frozen_string_literal: true

require "rails_helper"

RSpec.describe("collections/index", type: :view) do
  include_examples "a turbo_frame", "main_content"

  describe "grid layout" do
    it "renders the grid layout" do
      render

      assert_select "div[class=?]", "grid lg:grid-rows-4 lg:grid-cols-3 gap-4", count: 1 do
        assert_select "div[class=?]", "lg:col-span-1 lg:row-span-4", count: 1
        assert_select "div[class=?]", "lg:col-span-2 lg:row-span-4 flex lg:justify-center pr-4", count: 1 do
          assert_select "turbo-frame[id=?][src=?]", "calculator", calculator_path, count: 1
        end
      end
    end
  end
end
