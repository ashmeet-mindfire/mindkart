class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :book_id
      t.integer :quantity

      t.timestamps
    end
  end
end
