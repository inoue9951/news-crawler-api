class Api::StocksController < ApplicationController

  def index
    stock = Stock.order('created_at DESC').first
    binding.pry
    json_data = stock.get_json  

    category = check_query "category"
    data = []
    if category
      data = json_data["list"].select { |item| item["category"] == category } 
      json_data = { list: data }
    end  

    render json: json_data

  end
end
