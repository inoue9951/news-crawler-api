class Api::BrandListsController < ApplicationController

  def index
    brand_list = BrandList.order('created_at DESC').first
    file_name = "#{I18n.l(brand_list.created_at, format: :for_file)}-brand-list.json"
    json_path = "app/download/brand_list/json/#{file_name}"
    json_data = File.open json_path do |file|  
      JSON.load file
    end

    #フィルター
    option = ["category", "TOPIX_33_code", "TOPIX_33", "TOPIX_17_code", "TOPIX_17", "scale_code", "scale"]
    if (request.query_parameters.keys & option).present?
      list = json_data["list"]
      data = []
      request.query_parameters.each do |key, value|
        data.concat list.select { |item| item[key].rstrip == value }
        list = list - data
      end
    end
    json_data = { list: data }
    render json: json_data
  end
end
