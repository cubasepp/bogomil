# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Internet.name }
    email { Faker::Internet.email }
    password { "start1234" }

    trait :admin do
      name { "Admin" }
      email { "admin@bogomil.io" }
      password { "start1234" }
    end
  end
end
