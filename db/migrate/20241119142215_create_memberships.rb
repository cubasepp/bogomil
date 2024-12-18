# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table(:memberships) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.string(:role)
      t.references(:memberable, polymorphic: true, null: false)

      t.timestamps
    end
  end
end
