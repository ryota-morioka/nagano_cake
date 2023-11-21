class CartItem < ApplicationRecord
   # アソシエーション
  belongs_to :item
  belongs_to :customer

  # cartバリデーション
  validates :amount, presence: true

  def subtotal
    item.with_tax_price * amount.to_i
  end
end
