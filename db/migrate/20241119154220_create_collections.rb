# frozen_string_literal: true

class CreateCollections < ActiveRecord::Migration[7.1]
  def change
    create_table(:collections) do |t|
      t.references(:collectable, polymorphic: true, null: false)

      t.timestamps
    end
  end
end
