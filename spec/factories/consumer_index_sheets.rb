# frozen_string_literal: true

FactoryBot.define do
  factory :consumer_index_sheet do
    name { "Consumer Index Germany" }
    description { "A collection of the consumer index" }

    public { true }

    type { ConsumerIndexSheet }
  end
end
