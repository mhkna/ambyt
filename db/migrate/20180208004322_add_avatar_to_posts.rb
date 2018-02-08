class AddAvatarToPosts < ActiveRecord::Migration[5.1]
  def change
    add_attachment :posts, :avatar
  end
end
