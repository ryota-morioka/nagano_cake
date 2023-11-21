class RecipientAddress < ApplicationRecord
  belongs_to :customer
  	validates :customer_id, :name, :recipient_address, presence: true
  	validates :postal_code, length: {is: 7}, numericality: { only_integer: true }

  		# order/newで使用
	def order_recipient_address
			self.postal_code + self.recipient_address + self.name
	end
  # ここに関連付けやバリデーションを書くことができます
end