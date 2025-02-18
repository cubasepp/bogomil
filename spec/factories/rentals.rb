# frozen_string_literal: true

FactoryBot.define do
  factory :rental do
    description { Faker::Lorem.word }
    valid_from { Date.current }
    tenants { [build(:tenant)] }
    rents { [build(:rent)] }
  end
end
