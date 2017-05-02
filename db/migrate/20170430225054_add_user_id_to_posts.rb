class AddUserIdToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :user_id, :integer
  	add_index :posts, :user_id
  	remove_column :posts, :nombre
  end
end
