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

    def _to_partial_path
      "#{base_class.model_name.collection}/types/#{model_name.element}"
    end

    def accessable(user: Current.user)
      user.spread_sheets.or(SpreadSheet.where(public: true))
    end
  end
end
