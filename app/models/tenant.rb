# frozen_string_literal: true

class Tenant < ApplicationRecord
  belongs_to :living_unit

  store :properties,
    accessors: [
      :first_name,
      :last_name,
      :email,
      :phone_number,
    ],
    coder: JSON

  validates :first_name, :last_name, :email, :phone_number, presence: true
end
