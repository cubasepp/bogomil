# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "start1234" }

    trait :admin do
      name { "Admin" }
      sequence :email do |n|
        "admin-#{n}@bogomil.io"
      end
      password { "start1234" }
    end
  end
end
