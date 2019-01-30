class DestroyCategoryList < ActiveRecord::Migration[5.2]
  def change
    drop_table:category_lists
    drop_table:ar_internal_metadata
  end
end
