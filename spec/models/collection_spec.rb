# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Collection, type: :model) do
  describe "associations" do
    it { should have_one(:membership).required(true).touch(true).dependent(:destroy) }
    it { should have_many(:memberships).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "enum" do
    it {
      should define_enum_for(:type).with_values(
        ["real_estate"].index_by(&:itself),
      ).with_default("real_estate").backed_by_column_of_type(:string)
    }
  end
end
