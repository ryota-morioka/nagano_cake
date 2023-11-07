class CartItem < ApplicationRecord
   # アソシエーション
  belongs_to :customer
  belongs_to :item

  # cartバリデーション
  validates :amount, presence: true

  def subtoal
    item.with_tax_price * amount.to_i
  end
end
