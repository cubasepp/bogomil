# frozen_string_literal: true

class CreateRealEstates < ActiveRecord::Migration[8.0]
  def change
    create_table(:real_estates) do |t|
      t.string(:name)
      t.json(:address)
      t.json(:properties)
      t.json(:heating)
      t.json(:solar_plant)

      t.timestamps
    end
  end
end
