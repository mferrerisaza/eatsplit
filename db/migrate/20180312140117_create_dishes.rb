class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :category
      t.references :restaurant, foreign_key: true
      t.string :name
      t.text :description
      t.string :photo
      t.monetize :price, currency: { present: false }

      t.timestamps
    end
  end
end
