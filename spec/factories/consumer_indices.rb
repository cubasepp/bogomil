# frozen_string_literal: true

FactoryBot.define do
  factory :consumer_index do
    year { Time.zone.now.year }
    month { 1 }
    index { 119.3 }
    previous_yer { 2.3 }
    previous_month { 1.8 }
  end
end
