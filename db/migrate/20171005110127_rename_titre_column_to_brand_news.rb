class RenameTitreColumnToBrandNews < ActiveRecord::Migration[5.1]
  def change
    rename_column :brand_news, :company_name, :brand_name
  end
end
