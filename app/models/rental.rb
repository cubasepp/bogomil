# frozen_string_literal: true

class Rental < ApplicationRecord
  include Broadcast::Rental
  belongs_to :living_unit
  has_many :tenants, dependent: :destroy
  has_many :rents, dependent: :destroy

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  accepts_nested_attributes_for :tenants, :rents, reject_if: :all_blank

  delegate :real_estate, to: :living_unit

  after_initialize :build_associations, if: :new_record?

  store :properties,
    accessors: [
      :description,
    ],
    coder: JSON

  validates :valid_from, :description, presence: true

  def archive!
    update(archived: true)
  end

  private

  def build_associations
    tenants.build if tenants.empty?
    rents.build if rents.empty?
  end
end
