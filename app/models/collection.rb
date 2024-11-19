# frozen_string_literal: true

class Collection < ApplicationRecord
  self.inheritance_column = :_type_disabled
  include Memberable

  validates :name, presence: true

  enum :type, ["real_estate"].index_by(&:itself), default: "real_estate"
end
