class AddUserPickingToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :picking_user_id, :bigint, index: true
    add_foreign_key :orders, :users, column: :picking_user_id
  end
end
