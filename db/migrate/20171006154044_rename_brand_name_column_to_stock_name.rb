class RenameBrandNameColumnToStockName < ActiveRecord::Migration[5.1]
  def change
    rename_column :news, :brand_name, :stock_name
  end
end
