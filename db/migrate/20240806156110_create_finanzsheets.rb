# frozen_string_literal: true

class CreateFinanzsheets < ActiveRecord::Migration[7.1]
  def change
    create_table(:finanzsheets, &:timestamps)
  end
end
