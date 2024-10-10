# frozen_string_literal: true

class SpreadSheet < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  delegated_type :spread_sheetable, types: ["Property"]

  class << self
    def accessable(user: Current.user)
      user.spread_sheets.or(SpreadSheet.where(public: true))
    end
  end
end
