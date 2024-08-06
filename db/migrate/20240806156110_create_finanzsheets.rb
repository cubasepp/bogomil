class CreateFinanzsheets < ActiveRecord::Migration[7.1]
  def change
    create_table :finanzsheets do |t|

      t.timestamps
    end
  end
end
