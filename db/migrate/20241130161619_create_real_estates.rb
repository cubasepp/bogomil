class CreateRealEstates < ActiveRecord::Migration[7.2]
  def change
    create_table :real_estates do |t|
      t.string :name
      t.string :address
      t.string :building_properties

      t.timestamps
    end
  end
end
