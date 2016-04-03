class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  	 has_many :likes, as: :likeble

  	 
  	 def already_likes?(comment)
  self.likes.find(:all, :conditions => ['comment_id = ?', comment.id]).size > 0
end
end
