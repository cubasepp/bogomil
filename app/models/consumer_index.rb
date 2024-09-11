# frozen_string_literal: true

class ConsumerIndex < ApplicationRecord
  self.primary_key = [:year, :month]

  validates :year, uniqueness: { scope: :month }
end
