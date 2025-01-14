# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Tenant, type: :model) do
  describe "associations" do
    it { should belong_to(:living_unit) }
  end
end
