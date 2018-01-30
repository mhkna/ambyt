class RemoveIpFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :ip, :string
  end
end
