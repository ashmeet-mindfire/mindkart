class DropCartsTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :carts, if_exists: true
  end
end
