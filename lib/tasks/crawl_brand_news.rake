namespace :crawl_brand_news do
  desc "日顕新聞のサイトから銘柄に関するニュースを取得する"

  task :crawl, ['market', 'level'] => :environment do |task, args| 
    url = "https://www.nikkei.com/search/site/"
    BrandNewsCrawler::Crawler.set_capybara url

    brand_list = BrandList.order('created_at DESC').first
    brands = brand_list.get_values 'name', args[:market]
 
    puts args[:market]
    for keyword in brands do
      crawler = BrandNewsCrawler::Crawler.new keyword
      puts "start crawl"
      crawler.crawl args[:level].to_i
      puts "end crawl"
      news_list = BrandNews.pluck(:url)
      news = []
      crawler.links.each do |item|
        news << item if news_list.exclude? item[:url]
      end
      
      BrandNews.import news unless news.empty?
    end
  end
end
