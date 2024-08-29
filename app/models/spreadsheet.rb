# frozen_string_literal: true

class Spreadsheet < ApplicationRecord
  belongs_to :user

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
      user.spreadsheets
    end
  end
end
