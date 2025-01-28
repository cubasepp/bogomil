# frozen_string_literal: true

FactoryBot.define do
  factory :rent do
    cold_rent { 950 }
    heating_costs { 30 }
    incidental_costs { 30 }
    rent_type { "normal" }
    valid_from { Time.zone.today }
  end
end
