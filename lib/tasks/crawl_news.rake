namespace :crawl_news do
  desc "日顕新聞のサイトから銘柄に関するニュースを取得する"

  task :crawl, ['market', 'level'] => :environment do |task, args| 
    url = "https://www.nikkei.com/search/site/"
    NewsCrawler::Crawler.set_capybara url

    stock = Stock.order('created_at DESC').first
    stocks = stock.get_values 'name', args[:market]
 
    puts args[:market]
    for keyword in stocks do
      crawler = NewsCrawler::Crawler.new keyword
      puts "start crawl"
      crawler.crawl args[:level].to_i
      puts "end crawl"
      news_list = News.pluck(:url)
      news = []
      crawler.links.each do |item|
        news << item if news_list.exclude? item[:url]
      end
      
      News.import news unless news.empty?
    end
  end
end
