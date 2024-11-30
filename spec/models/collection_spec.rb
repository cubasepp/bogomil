# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Collection, type: :model) do
  describe "associations" do
    it { should have_delegated_type(:collectable) }
    it { should have_many(:memberships).inverse_of("user") }
  end
end
