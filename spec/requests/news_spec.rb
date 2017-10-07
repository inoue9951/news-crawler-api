require 'rails_helper'

RSpec.describe "News", type: :request do
  describe "GET /news" do
    
    context 'クエリに何も指定しない' do
      example "ステータスコード200で空のデータが返ってくる" do
        get api_news_index_path
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to be_empty
      end
    end

    context 'クエリにstock_nameを指定' do
      example "ステータスコード200でstock_nameがsample_stockのデータが返ってくる" do
        create(:news)
        get api_news_index_path(stock_name: "sample_stock")
        expect(response).to have_http_status(200)
        JSON.parse(response.body)["list"].each do |item|
          expect(item["stock_name"]).to eq("sample_stock")
        end
      end
    end

  end
end
