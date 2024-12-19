# frozen_string_literal: true

require "rails_helper"

RSpec.describe("real_estates/new", type: :view) do
  before(:each) do
    assign(:real_estate, FactoryBot.build(:real_estate))
  end

  include_examples "a main turbo_frame", "new_real_estate"

  it "renders new real_estate form" do
    render

    assert_select "form[action=?][method=?][id=?]", real_estates_path, "post", "new_real_estate" do
      assert_select "input[name=?]", "real_estate[name]"
      assert_select "a[href=?][data-turbo-frame=?]", root_path, "main_content"
    end
  end
end
