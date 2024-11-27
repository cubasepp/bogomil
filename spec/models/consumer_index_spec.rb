# frozen_string_literal: true

require "rails_helper"

RSpec.describe(ConsumerIndex, type: :model) do
  describe "validations" do
    it { should validate_uniqueness_of(:year).scoped_to(:month) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:month) }
  end

  describe "#id_as_para" do
    subject { FactoryBot.build_stubbed(:consumer_index, year: 2024, month: 1) }
    it {
      expect(subject.id).to(match_array([2024, 1]))
      expect(subject.id_as_param).to(eql("2024-1"))
    }
  end
end
