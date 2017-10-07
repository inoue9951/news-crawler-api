require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'uri'
require 'benchmark'


module NewsCrawler
  class Crawler
    include Capybara::DSL
    attr_reader :links

    def initialize(keyword)
      @links = []
      @url = "https://www.nikkei.com/search/site/"
      @keyword = keyword
      @page = 1
      open_page
    end

    def open_page(link = '')
      visit link
    end    

    def crawl(level)
      crawl_url = create_url @url, @keyword, @page
      open_page crawl_url
      n = get_pagination_num
      puts "企業名: #{@keyword}"
      puts "ページ数: #{n}"
      get_news_link
      level.times do |i|
        @page += 1
        break if @page > n || @page > level
        crawl_url = create_url @url, @keyword, @page
        open_page crawl_url
        get_news_link
      end
    end

    def wait_for_ajax
      until find("app-result")
      end
    end

    def get_pagination_num
      wait_for_ajax
      pagination_text = find(".m-search_result_total").text
      pagination_int = pagination_text.gsub(/,/, '').chop!.to_f
      puts("検索結果: #{pagination_int}")
      pagination_num = pagination_int.quo(20).to_f
      pagination_num.ceil
    end

    def get_news_link
      wait_for_ajax
      articles = find("app-result").all("article").each do |article|
        link = article.find("a")
        url = link[:href]
        title = link.find("h3").text
        date = link.find(".status").text[/（(.*?)）/, 1]
        @links.push({ stock_name: @keyword, title: title, url: url, date: Time.parse(date) })
      end
    end

    def self.set_capybara url
      Capybara.configure do |config|
        config.run_server = false
        config.current_driver = :poltergeist
        config.javascript_driver = :poltergeist
        config.app_host = url
        config.default_max_wait_time = 5
      end

      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(
          app, { timeoute: 120, js_errors: false }
         )
      end
    end

    def create_url url, keyword, page
      result_url = "#{url}?searchKeyword=#{keyword}&page=#{page}"
      result_url = URI.escape result_url
    end

  end
end


