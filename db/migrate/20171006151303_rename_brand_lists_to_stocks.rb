class RenameBrandListsToStocks < ActiveRecord::Migration[5.1]
  def change
    rename_table  :brand_lists, :stocks
  end
end
