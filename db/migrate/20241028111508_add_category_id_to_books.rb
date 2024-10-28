class AddCategoryIdToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :category_id, :integer
  end
end
