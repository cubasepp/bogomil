# frozen_string_literal: true

class CreateConsumerIndices < ActiveRecord::Migration[7.1]
  def change
    create_table(:consumer_indices, primary_key: [:year, :month]) do |t|
      t.integer(:year)
      t.integer(:month)
      t.decimal(:index)
      t.decimal(:previous_year)
      t.decimal(:previous_month)

      t.timestamps
      t.index([:year, :month], unique: true)
    end
  end
end
