# == Schema Information
#
# Table name: brand_news
#
#  id           :integer          not null, primary key
#  company_name :string(255)
#  title        :string(255)
#  url          :string(255)
#  date         :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class BrandNews < ApplicationRecord
end
