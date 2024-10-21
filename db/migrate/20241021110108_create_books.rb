class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :ISBN
      t.string :genre
      t.decimal :price
      t.text :description
      t.integer :stock_quantity
      t.string :cover_image
      t.date :published_date
      t.string :publisher

      t.timestamps
    end
  end
end
