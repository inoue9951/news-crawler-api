# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  stock_name :string(255)      not null
#  title      :string(255)      not null
#  url        :string(255)      not null
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe News, type: :model do
  
  example "バリデーションが動作している" do
    columns = ["stock_name", "title", "url", "date"]
    columns.each do |column|
      news = News.new(stock_name: "stock_name", title: "news_title", 
                      url: "http://sample.com", date: Time.new)
      news[column] = nil
      expect(news).not_to be_valid
      expect(news.errors[column]).to be_present
    end
  end
end
