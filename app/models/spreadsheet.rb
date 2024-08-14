# frozen_string_literal: true

class Spreadsheet < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  class << self
    def accessable(user: Current.user)
      user.spreadsheets
    end
  end
end
