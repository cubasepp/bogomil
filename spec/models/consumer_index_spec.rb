# frozen_string_literal: true

require "rails_helper"

RSpec.describe(ConsumerIndex, type: :model) do
  describe "validations" do
    it { should validate_uniqueness_of(:year).scoped_to(:month) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:month) }
  end
end
