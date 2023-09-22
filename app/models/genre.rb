class Genre < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :orders
end
