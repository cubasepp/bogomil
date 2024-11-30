# frozen_string_literal: true

require "rails_helper"

RSpec.describe("real_estates/show", type: :view) do
  let(:real_estate) do
    FactoryBot.build_stubbed(:real_estate, id: 1)
  end

  before(:each) do
    assign(:real_estate, real_estate)
  end

  it_behaves_like "a default card", 1
  include_examples "a main turbo_frame", "real_estate_1"

  it "renders the show page" do
    render
    assert_select "a[href=?]", edit_real_estate_path(1), count: 1
    assert_select "a[href=?][data-turbo-method=?][data-turbo-frame=?]", real_estate_path(1), "delete", "_top", count: 1
  end
end
