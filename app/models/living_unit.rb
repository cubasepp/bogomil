# frozen_string_literal: true

class LivingUnit < ApplicationRecord
  include Broadcast::LivingUnit
  belongs_to :real_estate

  after_initialize :set_default

  has_many :tenants, dependent: :destroy
  has_many :rents, dependent: :destroy

  store_accessor :properties,
    :rooms,
    :living_space,
    :own_use

  validates :name, presence: true
  validates :living_space, :rooms, numericality: true

  class << self
    def accessable(user: Current.user)
      where(real_estate_id: user.real_estate_ids)
    end
  end

  private

  def set_default
    self.name ||= I18n.t("living_unit.default.name")
    self.rooms ||= 0
    self.living_space ||= 0
  end
end
