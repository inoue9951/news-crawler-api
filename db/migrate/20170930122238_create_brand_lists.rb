class CreateBrandLists < ActiveRecord::Migration[5.1]
  def change
    create_table :brand_lists do |t|

      t.timestamps
    end
  end
end
