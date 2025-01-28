# frozen_string_literal: true

require "rails_helper"

RSpec.describe("real_estates/show", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end

  before(:each) do
    assign(:real_estate, real_estate)
  end

  include_examples "a main turbo_frame", "real_estate_1"

  it "renders the show page" do
    render
    assert_select "div[role=?]", "tablist", count: 1 do
      assert_select "a[role=?]", "tab", count: 3
      assert_select "form[action=?][method=?][id=?]", real_estate_path(1), "post", "edit_real_estate_1" do
        assert_select "input[name=?][disabled=?]", "real_estate[name]", "disabled"
      end
    end
    assert_select "a[href=?]", edit_real_estate_path(1), count: 1
  end
end
