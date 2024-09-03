# frozen_string_literal: true

require "rails_helper"

RSpec.describe(ConsumerIndex, type: :model) do
  describe "validations" do
    it { should validate_uniqueness_of(:year).scoped_to(:month) }
  end
end
