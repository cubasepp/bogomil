# frozen_string_literal: true

class CreateSpreadSheets < ActiveRecord::Migration[7.1]
  def change
    create_table(:spread_sheets) do |t|
      t.string(:name)
      t.text(:description)
      t.belongs_to(:user)
      t.boolean(:public, default: false)
      t.string(:type)

      t.timestamps
    end
  end
end
