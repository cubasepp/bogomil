# frozen_string_literal: true

FactoryBot.define do
  factory :living_unit do
    name { "Untitled" }
    description { Faker::Lorem.sentence }
  end
end
