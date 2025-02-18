# frozen_string_literal: true

class CreateRentals < ActiveRecord::Migration[7.2]
  def change
    create_table(:rentals) do |t|
      t.string(:properties)
      t.date(:valid_from)
      t.boolean(:archived, default: false)
      t.references(:living_unit, null: false, foreign_key: true)

      t.timestamps
    end

    create_table(:tenants) do |t|
      t.string(:properties)
      t.references(:rental, null: false, foreign_key: true)

      t.timestamps
    end

    create_table(:rents) do |t|
      t.decimal(:cold_rent, precision: 10, scale: 2, default: 0.00)
      t.decimal(:heating_costs, precision: 10, scale: 2, default: 0.00)
      t.decimal(:incidental_costs, precision: 10, scale: 2, default: 0.00)
      t.string(:rent_type, null: false)
      t.date(:valid_from)
      t.references(:rental, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
