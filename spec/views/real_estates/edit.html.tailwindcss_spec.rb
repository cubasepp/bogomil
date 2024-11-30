# frozen_string_literal: true

require "rails_helper"

RSpec.describe("real_estates/edit", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end

  before(:each) do
    assign(:real_estate, real_estate)
  end

  it_behaves_like "a default card"
  include_examples "a main turbo_frame", "real_estate_1"

  it "renders edit real_estate form" do
    render

    assert_select "form[action=?][method=?][id=?]", real_estate_path(1), "post", "edit_real_estate_1" do
      assert_select "input[name=?]", "real_estate[name]"
      assert_select "a[href=?][data-turbo-frame=?]", real_estate_path(1), "main_content"
    end
  end
end
