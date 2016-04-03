class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :f_name, :string
    add_column :users, :l_name, :string
    add_column :users, :password, :string
    add_column :users, :email_id, :string
    add_column :users, :user_id, :string
     add_column :users, :age, :string
      add_column :users, :dob, :date
       add_column :users, :sex, :string
  end
end
