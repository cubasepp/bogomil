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

    create_table(:tenants) do |t|
      t.string(:name)
      t.string(:properties)
      t.datetime(:start_of_tenancy)
      t.boolean(:archived, default: false)
      t.references(:living_unit, null: false, foreign_key: true)

      t.timestamps
    end

    create_table(:rents) do |t|
      t.string(:amounts)
      t.datetime(:valid_from)
      t.references(:living_unit, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
