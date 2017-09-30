require 'nokogiri'
require 'open-uri'
require 'spreadsheet'
require 'json'

scheme = "http://"
fqdn = "www.jpx.co.jp"
path = "/markets/statistics-equities/misc"
file = "/01.html"

url = scheme + fqdn + path + file

pattern = /.*(\.xls)/
xls_url = nil

doc = Nokogiri.HTML(open(url))
doc.css('a').each do |element|
  xls_url = scheme + fqdn + element[:href] if pattern.match element[:href]
end

d = Date.today
date = d.year.to_s + "-" + d.month.to_s
xls_path = "./xls/#{date}-brand-list.xls"

if xls_url
  open xls_url do |xls|
    open xls_path, "w+b" do |output|
      output.write xls.read
    end
  end
  true
else
  false
end

brand_list_xls = Spreadsheet.open xls_path, 'r'
brand_list = brand_list_xls.worksheet 0
list = brand_list.rows
list.delete_at 0
array = []
list.each do |row|
  data = {
    code: format("%.0f", row[1]),
    name: row[2],
    category: row[3],
    TOPIX_33_code: row[4] != '-' ? format("%.0f", row[4]) : nil,
    TOPIX_33: row[5] != '-' ? row[5] : nil,
    TOPIX_17_code: row[6] != '-' ? format("%.0f", row[6]) : nil,
    TOPIX_17: row[7] != '-' ? row[7] : nil,
    scale_code: row[8] != '-' ? format("%.0f", row[8]) : nil,
    scale: row[9] != '-' ? row[9] : nil
  }
  array.push data
end

json = { list: array }
json_path = "./json/#{date}-brand-list.json"

File.open json_path, "w" do |file|
  file.puts JSON.pretty_generate json
end


