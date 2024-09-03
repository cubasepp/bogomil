# frozen_string_literal: true

class ConsumerIndex < ApplicationRecord
  validates :year, uniqueness: { scope: :month }
end
