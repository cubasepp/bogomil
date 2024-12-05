# frozen_string_literal: true

class CreateRealEstates < ActiveRecord::Migration[7.2]
  def change
    create_table(:real_estates) do |t|
      t.string(:name)
      t.string(:address)
      t.string(:properties)
      t.string(:heating)
      t.string(:solar_plant)

      t.timestamps
    end
  end
end
