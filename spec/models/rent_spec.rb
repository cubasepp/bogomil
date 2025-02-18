# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Rent, type: :model) do
  describe "associations" do
    it { should belong_to(:rental) }
  end

  describe "validations" do
    it { should validate_presence_of(:valid_from) }
    it { should validate_numericality_of(:cold_rent) }
    it { should validate_numericality_of(:heating_costs) }
    it { should validate_numericality_of(:incidental_costs) }

    it {
      should validate_inclusion_of(:rent_type).in_array(["normal", "graduated", "index"])
    }
  end
end
