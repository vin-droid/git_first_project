class Like < ActiveRecord::Base
  belongs_to :likeble, polymorphic: true
  belongs_to :user
  validates :likeble_type , :uniqueness => {:scope => [:likeble_id, :user_id]}
end
