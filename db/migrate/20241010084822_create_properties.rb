# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table(:properties) do |t|
      t.string(:rent_type)
      t.string(:property_type)
      t.decimal(:size)
      t.string(:size_unit)
      t.decimal(:room_count)

      t.timestamps
    end
  end
end
