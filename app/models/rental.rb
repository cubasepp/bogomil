# frozen_string_literal: true

class Rental < ApplicationRecord
  belongs_to :living_unit
  has_many :tenants, dependent: :destroy
  has_many :rents, dependent: :destroy

  accepts_nested_attributes_for :tenants, :rents

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
