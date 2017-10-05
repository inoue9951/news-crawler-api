class CreateBrandNews < ActiveRecord::Migration[5.1]
  def change
    create_table :brand_news do |t|
      t.string :company_name
      t.string :title
      t.string :url
      t.date :date

      t.timestamps
    end
  end
end
