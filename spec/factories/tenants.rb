# frozen_string_literal: true

FactoryBot.define do
  factory :tenant do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
