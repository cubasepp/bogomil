# frozen_string_literal: true

class RealEstate < ApplicationRecord
  include Memberable, Collectable

  store :address, accessors: [:street, :zip_code, :city], coder: JSON
  store :building_properties, accessors: [:rooms, :size], coder: JSON

  validates :name, presence: true
end
