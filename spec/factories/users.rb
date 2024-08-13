# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "Admin" }
    email { "admin@bogomil.io" }
    password { "start1234" }
  end
end
