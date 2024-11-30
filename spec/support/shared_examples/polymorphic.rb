# frozen_string_literal: true

RSpec.shared_examples("memberable") do
  it { should have_one(:membership).required(true).touch(true).dependent(:destroy) }
  it { should have_many(:memberships).dependent(:destroy) }
end

RSpec.shared_examples("collectable") do
  it { should have_one(:collection).required(true).touch(true).dependent(:destroy) }
end
