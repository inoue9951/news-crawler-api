FactoryGirl.define do
  factory :news do
    stock_name "sample_stock"
    title  "sample"
    url "http://sample.com"
    date Time.new
  end
end
