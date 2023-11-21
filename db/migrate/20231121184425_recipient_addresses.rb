class RecipientAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :recipient_addresses do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :recipient_address, null: false

      t.timestamps
    end
  end
end
