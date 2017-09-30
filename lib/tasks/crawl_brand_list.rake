namespace :crawl_brand_list do
  desc "銘柄一覧を取得し、JSONファイルとして保存する"

  task crawl: :environment do
    dir_path = "#{Rails.root}/app/download/brand_list"
    url = "http://www.jpx.co.jp/markets/statistics-equities/misc/01.html"
    page_url = "http://www.jpx.co.jp"
    br = BrandList.new
    br.transaction do
      br.save!
      xls_file = br.create_path 'xls'
      xls_path = "#{dir_path}/xls/#{xls_file}"
      json_file = br.create_path 'json'
      json_path = "#{dir_path}/json/#{json_file}"
      br.brand_list_crawl url, page_url, xls_path, json_path
    end
  end
end
