class AddIpAddressToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :ip_address, :string
  end
end
