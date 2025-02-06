# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Tenant, type: :model) do
  describe "associations" do
    it { should belong_to(:living_unit) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
  end
end
