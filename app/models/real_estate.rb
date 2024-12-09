# frozen_string_literal: true

class RealEstate < ApplicationRecord
  include Memberable, Collectable

  HEATING_TYPES = ["heat_pump_air", "heat_pump_water", "oil", "gas"].freeze

  store :address, accessors: [:street, :zip_code, :city], coder: JSON
  store :heating,
    accessors: [
      :type,
      :manufacturer,
      :designation,
      :installed_at,
    ],
    coder: JSON,
    prefix: true
  store :properties,
    accessors: [
      :units,
      :space,
      :built_at,
      :renovated_at,
      :energy_certificate,
    ],
    coder: JSON
  store :solar_plant,
    accessors: [
      :present,
      :manufacturer,
      :capacity,
      :designation,
      :battery_capacity,
      :installed_at,
    ],
    coder: JSON,
    prefix: true

  validates :name, presence: true
  validates :units, numericality: true
  validates :space, numericality: true

  validates :heating_type, inclusion: { in: HEATING_TYPES }

  validates :solar_plant_capacity, numericality: true
  validates :solar_plant_battery_capacity, numericality: true
end
