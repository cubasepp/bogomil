# frozen_string_literal: true

FactoryBot.define do
  factory :living_unit do
    name { "Untitled" }
    description { Faker::Lorem.sentence }
    real_estate { build(:real_estate) }
    rents { build_list(:rent, 1) }
  end
end
