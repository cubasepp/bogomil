# frozen_string_literal: true

FactoryBot.define do
  factory :financesheet do
    name { "Demo Sheet" }
    description { "Super demo Sheet" }

    association :user

    type { Financesheet }
  end
end
