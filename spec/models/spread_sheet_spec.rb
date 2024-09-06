# frozen_string_literal: true

require "rails_helper"

RSpec.describe(SpreadSheet, type: :model) do
  describe "associations" do
    it { should belong_to(:user).optional(true) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:type).in_array(described_class.types) }
  end
end
