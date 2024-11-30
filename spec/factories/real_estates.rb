# frozen_string_literal: true

FactoryBot.define do
  factory :real_estate do
    name { "Muster Objekt" }
    street { Faker::Address.street_name }
    zip_code { Faker::Address.postcode }
    city { Faker::Address.city }
    rooms { 3 }
    size { 80 }
    membership { build(:membership) }
  end
end
