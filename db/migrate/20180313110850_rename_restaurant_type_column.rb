class RenameRestaurantTypeColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :restaurants, :type, :category
  end
end
