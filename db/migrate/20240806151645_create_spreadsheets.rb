class CreateSpreadsheets < ActiveRecord::Migration[7.1]
  def change
    create_table :spreadsheets do |t|
      t.string :name
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
