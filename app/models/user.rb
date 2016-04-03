class User < ActiveRecord::Base

has_secure_password
has_many :posts
has_many :likes
has_many :comments


#====================== validation ===========================#

    validates :email_id, confirmation: true , presence: true ,uniqueness: true

validates :password_digest , presence: true  



#===================================Like & Dislike check ======================#

    def already_likes?(post ,like_type)
    
    	 self.likes.where(likeble_id: post.id ,user_id: self.id ,likeble_type: like_type ,like_status: true).count > 0
       
    end
     def already_dislikes?(post ,like_type)
    	
    	 self.likes.where(likeble_id: post.id ,user_id: self.id ,likeble_type: like_type,like_status: false).count > 0
       
    end
end
