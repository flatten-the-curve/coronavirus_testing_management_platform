class CreateHosts < ActiveRecord::Migration[5.2]
  def change
    create_table :hosts do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zipcode
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
