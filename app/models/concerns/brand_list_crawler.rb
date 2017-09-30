require 'nokogiri'
require 'open-uri'
require 'spreadsheet'
require 'json'

module BrandListCrawler

  class Crawler

    def crawl(url, page_url, xls_path, json_path)
      xls_url = search_xls_url url, page_url
      download_xls xls_url, xls_path
      save_json xls_path, json_path
    end
      
    private

      def search_xls_url(url, page_url)
        pattern = /.*(\.xls)/
        xls_url = nil
        doc = Nokogiri.HTML(open(url))
        doc.css('a').each do |element|
          xls_url = page_url + element[:href] if pattern.match element[:href]
        end
        xls_url
      end

      def download_xls(url, xls_path)
        open url do |xls|
          open xls_path, "w+b" do |output|
            output.write xls.read
          end
        end
      end

      def save_json(xls_path, json_path)
        xls = Spreadsheet.open xls_path, 'r'
        xls_sheet = xls.worksheet 0
        brand_list = xls_sheet.rows
        brand_list.delete_at 0

        brand_array = []
        brand_list.each do |row|
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
          brand_array.push data
        end
        json = { list: brand_array }
        File.open json_path, "w" do |file|
          file.puts JSON.pretty_generate json
        end
      end

  end

end

