# frozen_string_literal: true

FactoryBot.define do
  factory :real_estate do
    name { "Muster Objekt" }
    street { Faker::Address.street_name }
    zip_code { Faker::Number.number(digits: 5) }
    city { Faker::Address.city }
    units { 3 }
    space { 80 }
    built_at { "10/1987" }
    renovated_at { "12/2024" }
    energy_certificate { false }
    heating_type { "oil" }
    heating_manufacturer { "Demo Manufacturer" }
    heating_designation { "XYZ" }
    heating_installed_at { "10/1987" }
    solar_plant_present { "0" }

    membership { build(:membership) }
  end
end
