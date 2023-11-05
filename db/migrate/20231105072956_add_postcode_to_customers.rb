class AddPostcodeToCustomers < ActiveRecord::Migration[6.1]
  def up
    add_column :customers, :postcode, :string
  end

  def down
    remove_column :customers, :postcode, :string
  end
end
