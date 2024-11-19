# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    user { association :user, :admin }
    role { "viewer" }

    trait :owner do
      role { "owner" }
    end
  end
end
