# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Membership, type: :model) do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:memberable) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
  end

  describe "enum" do
    it {
      should define_enum_for(:role).with_values(
        ["owner", "viewer"].index_by(&:itself),
      ).with_default("owner").backed_by_column_of_type(:string)
    }
  end
end
