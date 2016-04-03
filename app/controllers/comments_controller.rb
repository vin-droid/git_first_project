class CommentsController < ApplicationController
  before_action :b_action,only:[:new,:show ,:edit,:update,:destroy ,:create]
  before_action :authorize ,except:[:show]
  def new
  
    @comments = @post.comments.all
    @comment = @post.comments.new
  end

  def show
  end

  def create   
       @comment = @post.comments.create(find_params)
  	   @comment.user_id = current_user.id

  	   if @comment.save! 
  	   	   redirect_to new_post_comments_path(@post)
  	   else
  	   		render 'new'
  	   end
  end

  def edit
      @comments = @post.comments.all
      @comment = Comment.find(params[:id])


  end
  def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
   		redirect_to  new_post_comments_path(@post)
  end

  def update
        @comment = Comment.find(params[:id])
        @comment.update(find_params)
        redirect_to new_post_comments_path(@post)
  end

  def like
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])

        if current_user.already_dislikes?(@comment,'Comment')
           like = current_user.likes.where(likeble_id: @comment.id ,
           user_id: current_user.id ,likeble_type: 'Comment').first
           like.like_status = true
           like.save
           redirect_to  new_post_comments_path(@post)

         else
           if current_user.already_likes?(@comment ,'Comment')
              redirect_to  new_post_comments_path(@post)
           else
              like = @comment.likes.create()
              like.user_id = current_user.id
              like.like_status = true
              like.save
              redirect_to  new_post_comments_path(@post) 
            end
        end
  end
  def dislike
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])


        if current_user.already_likes?(@comment,'Comment')
           like = current_user.likes.where(likeble_id: @comment.id ,
           user_id: current_user.id,likeble_type: 'Comment').first
           like.like_status = false
           like.save
           redirect_to  new_post_comments_path(@post)

        else
          if current_user.already_dislikes?(@comment ,'Comment')
             redirect_to  new_post_comments_path(@post)
          else
             like = @comment.likes.create()
             like.user_id = current_user.id
             like.like_status = false
             like.save
             redirect_to  new_post_comments_path(@post) 
          end
       end
  end

  private 
 def b_action
    @post = Post.find(params[:post_id])

 end
 def find_params
    params.require(:comment).permit(:desc,:user_id ,:post_id)
 end


end
