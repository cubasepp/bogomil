# frozen_string_literal: true

class Rent < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :living_unit
  RENT_TYPES = ["normal", "graduated", "index"].freeze

  attribute :rent_type, :string, default: "normal"

  validates :cold_rent, :heating_costs, :incidental_costs, numericality: true
  validates :rent_type, inclusion: { in: RENT_TYPES }
  validates :valid_from, presence: true

  def total
    cold_rent + heating_costs + incidental_costs
  end

  def active?
    valid_from <= Time.zone.now
  end
end
