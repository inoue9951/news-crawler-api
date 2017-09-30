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
 
  def brand_list_crawl url, page_url, xls_path, json_path
    crawler = BrandListCrawler::Crawler.new
    crawler.crawl url, page_url, xls_path, json_path
  end

  def create_path type
    time = I18n.l self.created_at, format: :for_file
    return "#{time}-brand-list.#{type}"
  end

end
