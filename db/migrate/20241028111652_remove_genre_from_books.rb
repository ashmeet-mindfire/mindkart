class RemoveGenreFromBooks < ActiveRecord::Migration[7.2]
  def change
    remove_column :books, :genre, :string
  end
end
