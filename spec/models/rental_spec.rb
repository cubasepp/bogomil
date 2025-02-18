# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Rental, type: :model) do
  describe "associations" do
    it { should belong_to(:living_unit) }

    it { should have_many(:rents).dependent(:destroy) }
    it { should have_many(:tenants).dependent(:destroy) }
  end

  describe "validations" do
  end
end
