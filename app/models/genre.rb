class Genre < ApplicationRecord
  has_many :items, dependent: :destroy


  validates :name, presence: true
  has_many :orders

end
