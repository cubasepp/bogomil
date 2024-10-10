# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    size { "9.99" }
    size_unit { "MyString" }
    rooms { "9.99" }
  end
end
