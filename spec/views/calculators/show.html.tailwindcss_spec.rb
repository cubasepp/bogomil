# frozen_string_literal: true

require "rails_helper"

RSpec.describe("calculators/show", type: :view) do
  include_examples "a main turbo_frame", "calculator"

  before(:each) do
    assign(:frames, [:old_index])
  end

  it "renders the show page" do
    render
    assert_select "turbo-frame[id=?]", "calculator", count: 1 do
      assert_select "div[class=?]", "flex flex-col lg:flex-row gap-2", count: 1 do
        assert_select "div[class=?]", "flex flex-col space-y-2", count: 1 do
          assert_select "div[data-controller=?]", "calculator-selection", count: 1
        end
        assert_select "div[class=?]", "", count: 1 do
          assert_select "turbo-frame[id=?]", "result", count: 1
        end
      end
    end
  end
end
