# frozen_string_literal: true

class Property < ApplicationRecord
  include SpreadSheetable

  enum :property_type, { flat: "flat", house: "house" }, suffix: true
  enum :rent_type, { normal: "normal", graduated: "graduated", index: "index" }, suffix: true
  enum :size_unit, { qm: "qm", inch: "inch" }, default: "qm"

  validates :size, numericality: true
end
