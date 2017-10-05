class Api::BrandListsController < ApplicationController

  def index
    brand_list = BrandList.order('created_at DESC').first
    json_data = brand_list.get_json  

    #フィルター
    option = ["category", "TOPIX_33_code", "TOPIX_33", "TOPIX_17_code", "TOPIX_17", "scale_code", "scale"]
    if (request.query_parameters.keys & option).present?
      list = json_data["list"]
      data = []
      request.query_parameters.each do |key, value|
        data.concat list.select { |item| item[key].rstrip == value }
        list = list - data
      end
      json_data = { list: data }
    end

    render json: json_data
  end
end
