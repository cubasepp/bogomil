# frozen_string_literal: true

class Tenant < ApplicationRecord
  belongs_to :living_unit

  store_accessor :properties,
    :first_name,
    :last_name,
    :email,
    :phone_number

  validates :first_name, :last_name, :email, :phone_number, presence: true
end
