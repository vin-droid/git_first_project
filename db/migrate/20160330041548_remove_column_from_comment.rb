class RemoveColumnFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :like, :integer
  end
end
