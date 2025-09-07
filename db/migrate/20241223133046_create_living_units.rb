# frozen_string_literal: true

class CreateLivingUnits < ActiveRecord::Migration[8.0]
  def change
    create_table(:living_units) do |t|
      t.string(:name)
      t.text(:description)
      t.json(:properties)
      t.references(:real_estate, null: false, foreign_key: true)

      t.timestamps
    end

    create_table(:tenants) do |t|
      t.string(:name)
      t.json(:properties)
      t.datetime(:start_of_tenancy)
      t.boolean(:archived, default: false)
      t.references(:living_unit, null: false, foreign_key: true)

      t.timestamps
    end

    create_table(:rents) do |t|
      t.decimal(:cold_rent, precision: 10, scale: 2, default: 0.00)
      t.decimal(:heating_costs, precision: 10, scale: 2, default: 0.00)
      t.decimal(:incidental_costs, precision: 10, scale: 2, default: 0.00)
      t.string(:rent_type, null: false)
      t.date(:valid_from)
      t.references(:living_unit, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
