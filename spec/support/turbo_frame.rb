# frozen_string_literal: true

RSpec.shared_examples("a turbo_frame") do |turbo_frame|
  it "renders #{turbo_frame} turbo_frame" do
    render

    assert_select "turbo-frame[id=?]", turbo_frame, count: 1
  end
end
