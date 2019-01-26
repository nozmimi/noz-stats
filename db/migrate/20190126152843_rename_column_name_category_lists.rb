class RenameColumnNameCategoryLists < ActiveRecord::Migration[5.2]
  def change
    rename_column :category_lists, :category_date, :data_update_date
  end
end
