class Address < ApplicationRecord
  def address_display
    '〒' + post_code + ' ' + address + ' ' + name
  end

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

end
