namespace :crawl_stock_list do
  desc "銘柄一覧を取得し、JSONファイルとして保存する"

  task crawl: :environment do
    dir_path = "#{Rails.root}"
    url = "http://www.jpx.co.jp/markets/statistics-equities/misc/01.html"
    page_url = "http://www.jpx.co.jp"

    crawler = StockListCrawler::Crawler.new
    stock = Stock.new
    
    stock.transaction do
      stock.save!
      xls_file = stock.create_path 'xls'
      xls_path = "#{dir_path}/#{xls_file}"
      json_file = stock.create_path 'json'
      json_path = "#{dir_path}/#{json_file}"
      crawler.crawl url, page_url, xls_path, json_path
    end
  end
end
