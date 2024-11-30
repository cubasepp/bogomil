# frozen_string_literal: true

require "rails_helper"

RSpec.describe(RealEstate, type: :model) do
  describe "associations" do
    it_should_behave_like "memberable"
    it_should_behave_like "collectable"
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
