# frozen_string_literal: true

class LivingUnit < ApplicationRecord
  include Broadcast::LivingUnit
  belongs_to :real_estate

  after_initialize :set_default

  has_many :tenants, dependent: :destroy
  has_many :rents, dependent: :destroy

  store :properties,
    accessors: [
      :rooms,
      :living_space,
      :own_use,
    ],
    coder: JSON

  validates :name, presence: true
  validates :living_space, :rooms, numericality: true

  private

  def set_default
    self.name ||= I18n.t("living_unit.default.name")
    self.rooms ||= 0
    self.living_space ||= 0
  end
end
