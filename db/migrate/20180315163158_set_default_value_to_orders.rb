class SetDefaultValueToOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :quantity, :integer, default: 1
  end
end
