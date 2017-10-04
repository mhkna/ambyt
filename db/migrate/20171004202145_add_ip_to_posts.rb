class AddIpToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :ip, :string
  end
end
