# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  stock_name :string(255)
#  title      :string(255)
#  url        :string(255)
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe News, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
