class ChangeDetailsToUser < ActiveRecord::Migration
  def change
  	 rename_column :users, :password, :password_digest
  	 rename_column :users , :user_id , :user_name
  end
end
