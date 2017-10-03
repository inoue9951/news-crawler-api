require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'uri'

url = "https://www.nikkei.com/search/site/?searchKeyword=ホウスイ"
url = URI.escape url

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

module Crawler
  class Test
    include Capybara::DSL

    

    def wait_for_ajax
      Timeout.timeout Capybara.default_max_wait_time do
        until find("app-result")
        end
      end
    end

    def get_pagination_num
      pagination_text = find(".m-search_result_total").text
      pagination_int = pagination_text.chop!.to_f
      pagination_num = pagination_int.quo(20).to_f
      pagination_num.ceil
    end

    def get_news_link
      visit ''
      wait_for_ajax
      articles = find("app-result").all("article").each do |article|
        link = article.find("a")
        url = link[:href]
        title = link.find("h3").text
        puts "#{title} : #{url}"
      end
    end
  end
end

crawler = Crawler::Test.new
crawler.get_news_link
num = crawler.get_pagination_num
puts num
