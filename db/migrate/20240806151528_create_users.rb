# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table(:users) do |t|
      t.string(:name)
      t.string(:email)
      t.string(:password_digest)
      t.datetime(:deactived_at)

      t.timestamps
    end
    add_index(:users, :email, unique: true)
  end
end
