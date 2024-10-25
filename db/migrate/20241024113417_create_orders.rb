class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end
