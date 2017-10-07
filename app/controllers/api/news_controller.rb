class Api::NewsController < ApplicationController
  def index
    stock_name = check_query 'stock_name'
    data = {}
    if stock_name
      data[:list] = News.where("stock_name = '#{stock_name}'").order('date DESC')    
    end      
    render json: data
  end

end
