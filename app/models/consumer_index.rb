# frozen_string_literal: true

class ConsumerIndex < ApplicationRecord
  validates :year, uniqueness: { scope: :month }
  validates :month, :year, presence: true

  def date
    Date.new(year, month, 1)
  end
end
