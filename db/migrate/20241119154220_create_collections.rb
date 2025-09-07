# frozen_string_literal: true

class CreateCollections < ActiveRecord::Migration[8.0]
  def change
    create_table(:collections) do |t|
      t.string(:user_settings)
      t.references(:collectable, polymorphic: true, null: false)

      t.timestamps
    end
  end
end
