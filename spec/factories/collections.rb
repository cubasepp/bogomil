# frozen_string_literal: true

FactoryBot.define do
  factory :collection do
    collectable { build(:real_estate) }
  end
end
