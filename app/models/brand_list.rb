# == Schema Information
#
# Table name: brand_lists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class BrandList < ApplicationRecord
  include BrandListCrawler
 
  def brand_list_crawl(url, page_url, xls_path, json_path)
    crawler = BrandListCrawler::Crawler.new
    crawler.crawl url, page_url, xls_path, json_path
  end

  def create_path(type)
    time = I18n.l self.created_at, format: :for_file
    return "#{time}-brand-list.#{type}"
  end

  def get_json
   file_name = create_path 'json'
   json_path = "app/download/brand_list/json/#{file_name}"
   json_data = File.open json_path do |file|  
     JSON.load file
   end
  end

  def get_values(key, category = "ETF・ETN")
    json = get_json
    array = []
    if category == "ETF・ETN"
      array = json["list"].select { |item| item["category"] != category }
    else 
      array = json["list"].select { |item| item["category"] == category }
    end
    values = array.map { |item| item[key] }
  end

end
