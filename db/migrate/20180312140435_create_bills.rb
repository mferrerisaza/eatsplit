class CreateBills < ActiveRecord::Migration[5.1]
  def change
    create_table :bills do |t|
      t.references :table, foreign_key: true
      t.string :status, default: "unpaid"
      t.monetize :balance, currency: { present: false }

      t.timestamps
    end
  end
end
