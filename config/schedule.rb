set :output, "/home/ubuntu/crawler-api/log/crontab.log"
set :environment, :development

every '0 0 3-5 * *' do
  rake "crawl_brand_list:crawl"
end

every 1.minute do
  command "echo 'mossmossmossmossmossmoss'"
end

