class RenameIsbnColumnInBooks < ActiveRecord::Migration[7.2]
  def change
    rename_column :books, :ISBN, :isbn
  end
end
