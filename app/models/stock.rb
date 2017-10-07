# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Stock < ApplicationRecord

  def create_path(type)
    time = I18n.l self.created_at, format: :for_file
    return "app/download/stock/#{type}/#{time}-stock-list.#{type}"
  end

  def get_json
   json_path = create_path "json"
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
