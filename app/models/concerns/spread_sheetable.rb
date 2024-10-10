# frozen_string_literal: true

module SpreadSheetable
  extend ActiveSupport::Concern

  included do
    has_one :spread_sheet, as: :spread_sheetable, required: true, touch: true, dependent: :destroy
  end
end
