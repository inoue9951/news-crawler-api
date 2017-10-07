# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Stock, type: :model do

  example "stockがDBへ保存される" do
    count = Stock.count
    Stock.create
    expect(Stock.count).to eq (count + 1)
  end

  example "jsonファイルへのパスが生成できる" do
    stock = Stock.create
    time = I18n.l stock.created_at, format: :for_file
    json_path = stock.create_path 'json'
    expect(json_path).to eq ("app/download/stock/json/#{time}-stock-list.json")
  end

end
