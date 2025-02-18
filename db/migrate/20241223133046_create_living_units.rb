# frozen_string_literal: true

class CreateLivingUnits < ActiveRecord::Migration[7.2]
  def change
    create_table(:living_units) do |t|
      t.string(:name)
      t.text(:description)
      t.string(:properties)
      t.references(:real_estate, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
