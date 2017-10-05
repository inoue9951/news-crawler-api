class Api::BrandNewsController < ApplicationController
  def index
    brand_name = check_query 'brand_name'
    data = {}
    if brand_name
      data[:list] = BrandNews.where("brand_name = '#{brand_name}'").order('date DESC')    
    end      
   render json: data
  end

  private 
    def check_query key
      if request.query_parameters[key]
        return request.query_parameters[key]
      else
        return false
      end
    end
end
