# frozen_string_literal: true

class ConsumerIndex < ApplicationRecord
  self.primary_key = [:year, :month]

  validates :year, uniqueness: { scope: :month }
  validates :month, :year, presence: true

  def date
    Date.new(year, month, 1)
  end

  def id_as_param
    id.join("-")
  end
end
