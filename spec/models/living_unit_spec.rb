# frozen_string_literal: true

require "rails_helper"

RSpec.describe(LivingUnit, type: :model) do
  describe "associations" do
    it { should belong_to(:real_estate) }

    it { should have_many(:tenants).dependent(:destroy) }
    it { should have_many(:rents).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:living_space) }
    it { should validate_numericality_of(:rooms) }
  end
end
