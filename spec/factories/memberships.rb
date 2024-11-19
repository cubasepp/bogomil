# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    user { associaction :user, :admin }
    role { "owner" }
    accessable { nil }

    trait :viewer do
      role { "viewer" }
    end
  end
end
