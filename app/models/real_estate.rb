# frozen_string_literal: true

class RealEstate < ApplicationRecord
  include Memberable, Collectable, Broadcast::RealEstate

  HEATING_TYPES = ["heat_pump_air", "heat_pump_water", "oil", "gas"].freeze
  DATE_FORMAT = %r{\A(0?[1-9]|1[0-2])\/\d{4}\z}

  store_accessor :address, :street, :zip_code, :city
  store_accessor :heating,
    :type,
    :manufacturer,
    :designation,
    :installed_at,
    prefix: true

  store_accessor :properties,
    :units,
    :space,
    :built_at,
    :renovated_at,
    :energy_certificate

  store_accessor :solar_plant,
    :present,
    :manufacturer,
    :capacity,
    :designation,
    :battery_capacity,
    :installed_at,
    prefix: true

  has_many :living_units, dependent: :destroy

  validates :name, :street, :city, presence: true
  validates :zip_code, :space, :units, numericality: true
  validates :heating_type, inclusion: { in: HEATING_TYPES }
  validates :renovated_at,
    :built_at,
    :heating_installed_at,
    format: { with: DATE_FORMAT, message: :date_format },
    allow_blank: true

  with_options if: :solar_plant_present? do
    validates :solar_plant_capacity, numericality: true
    validates :solar_plant_battery_capacity, numericality: true, allow_nil: true
    validates :solar_plant_installed_at, format: { with: DATE_FORMAT, message: :date_format }
  end

  def childrens
    living_units
  end

  def solar_plant_present
    super || false
  end

  def solar_plant_present?
    solar_plant_present == "1"
  end
end
