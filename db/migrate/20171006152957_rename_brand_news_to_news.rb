class RenameBrandNewsToNews < ActiveRecord::Migration[5.1]
  def change
    rename_table :brand_news, :news
  end
end
