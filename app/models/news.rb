# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  stock_name :string(255)      not null
#  title      :string(255)      not null
#  url        :string(255)      not null
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class News < ApplicationRecord
  validates :stock_name, :title, :url, :date, presence: true
end
