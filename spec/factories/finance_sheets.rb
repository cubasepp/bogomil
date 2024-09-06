# frozen_string_literal: true

FactoryBot.define do
  factory :finance_sheet do
    name { "Finance sheet one" }
    description { "Am i broke?" }

    association :user

    type { FinanceSheet }
  end
end
