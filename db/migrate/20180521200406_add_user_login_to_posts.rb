class AddUserLoginToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :user_login, :string
    add_index :posts, :author_ip
    add_index :posts, :user_login
  end
end
