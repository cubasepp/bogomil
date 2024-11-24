# frozen_string_literal: true

RSpec.shared_examples("a default card") do |card_action|
  it "renders a complete box" do
    render

    assert_select "div[class=?]", "card-body", count: 1
    assert_select "h2[class=?]", "card-title", count: 1
    assert_select "div[class*=?]", "card-actions", count: card_action || 0
  end
end
