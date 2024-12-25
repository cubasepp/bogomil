# frozen_string_literal: true

require "rails_helper"

RSpec.describe(RealEstate, type: :model) do
  describe "associations" do
    it_should_behave_like "memberable"
    it_should_behave_like "collectable"
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:street) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_numericality_of(:space) }
    it { should validate_numericality_of(:units) }
    it {
      should validate_inclusion_of(:heating_type).in_array(["heat_pump_air", "heat_pump_water", "oil", "gas"])
    }
    it { should allow_values("02/2024", "2/2024", nil).for(:renovated_at) }
    it { should allow_values("02/2024", "2/2024", nil).for(:built_at) }
    it { should allow_values("02/2024", "2/2024", nil).for(:heating_installed_at) }
  end

  describe "validations solar_plant_present" do
    subject { described_class.new(solar_plant_present: "1") }

    it { should allow_values("02/2024", "2/2024").for(:solar_plant_installed_at) }
    it { should validate_numericality_of(:solar_plant_capacity) }
    it { should validate_numericality_of(:solar_plant_battery_capacity).allow_nil }
  end
end
