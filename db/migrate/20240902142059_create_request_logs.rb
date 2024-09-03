# frozen_string_literal: true

class CreateRequestLogs < ActiveRecord::Migration[7.1]
  def change
    create_table(:request_logs) do |t|
      t.text(:body)
      t.text(:data)
      t.text(:class_name)
      t.integer(:status_code)

      t.timestamps
    end
  end
end
