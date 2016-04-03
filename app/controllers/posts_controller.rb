class PostsController < ApplicationController
  before_action :b_action , only:[ :show ,:update ,:destroy ,:edit ]
  before_action :authorize ,except:[:index ,:show]

  def new
       @post = current_user.posts.new
  end

  def index
  	@posts = Post.all
  end

  def show
  end

  def create


  	   @post = current_user.posts.create(find_params)
  	   if @post.save 
  	   	   redirect_to post_path(@post)
  	   else
  	   		render 'new'
  	   end
  end

  def edit
      
  end
  def destroy
      @post.destroy
   		redirect_to @post
  end

  def update
        @post.update(find_params)
        redirect_to root_path
  end

  def like
      @post = Post.find(params[:post_id])


    if current_user.already_dislikes?(@post ,'Post')
       like = current_user.likes.where(likeble_id: @post.id ,
       user_id: current_user.id ,likeble_type: 'Post' ).first
       like.like_status = true
       like.save
       redirect_to root_path

     else
        if current_user.already_likes?(@post ,'Post')
           redirect_to root_path
        else
           like = @post.likes.create
           like.user_id = current_user.id
           like.like_status = true
           like.save
           redirect_to root_path
        end
    end
  end

  def dislike
      @post = Post.find(params[:post_id])

    if current_user.already_likes?(@post ,'Post')
       like = current_user.likes.where(likeble_id: @post.id ,
       user_id: current_user.id ,likeble_type: 'Post' ).first
       like.like_status = false
       like.save
       redirect_to root_path

     else
        if current_user.already_dislikes?(@post ,'Post')
           redirect_to root_path
        else
           like = @post.likes.create
           like.user_id = current_user.id
           like.like_status = false
           like.save
           redirect_to root_path
        end
    end
  end


  private 
 def b_action
     @post = Post.find(params[:id])
 end
 def find_params
    params.require(:post).permit(:title ,:body)
 end


end
