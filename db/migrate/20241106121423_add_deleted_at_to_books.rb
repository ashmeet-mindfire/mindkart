class AddDeletedAtToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :deleted_at, :datetime
  end
end
