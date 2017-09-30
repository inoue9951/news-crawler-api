require 'nokogiri'
require 'open-uri'

scheme = "http://"
fqdn = "www.jpx.co.jp"
path = "/markets/statistics-equities/misc"
file = "/01.html"

url = scheme + fqdn + path + file

pattern = /.*(\.xls)/
xls_url = nil

doc = Nokogiri.HTML(open(url))
doc.css('a').each do |element|
  xls_url = scheme + fqdn + element[:href] if pattern.match(element[:href])
end

d = Date.today
xls_path = "./xls/#{d.year}-#{d.month}-brand-list.xls"

if xls_url
  open xls_url do |xls|
    open xls_path, "w+b" do |output|
      output.write(xls.read)
    end
  end
  true
else
  false
end
