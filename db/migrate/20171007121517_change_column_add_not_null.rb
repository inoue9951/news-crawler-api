class ChangeColumnAddNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column :news, :stock_name, :string, null: false
    change_column :news, :title, :string, null: false
    change_column :news, :url, :string, null: false
    change_column :news, :date, :date, null: false
  end
end
