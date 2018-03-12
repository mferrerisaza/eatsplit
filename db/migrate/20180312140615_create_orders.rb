class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :dish, foreign_key: true
      t.references :bill, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :quantity
      t.string :status
      t.monetize :amount, currency: { present: false }

      t.timestamps
    end
  end
end
