# frozen_string_literal: true

class SpreadSheet < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :type, inclusion: { in: ->() { types } }

  class << self
    def types
      @types = descendants.map(&:name)
    end

    def for_type(type)
      return type.constantize if types.include?(type)

      self
    end

    def accessable(user: Current.user)
      user.spread_sheets.or(SpreadSheet.where(public: true))
    end
  end

  # def to_partial_path
  #   "super"
  # end
end
