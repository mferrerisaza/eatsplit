class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :type
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :logo
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
