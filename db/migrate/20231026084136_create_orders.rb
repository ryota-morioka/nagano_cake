class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id, null: false
      t.string :recipient_name, null: false
      t.string :recipient_address, null: false
      t.string :recipient_postal_code, null: false
      t.integer :shipping_fee, null: false
      t.integer :billing_amount, null: false
      t.integer :payment_method, null: false


      t.timestamps
    end
  end
end
