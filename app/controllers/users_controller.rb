class UsersController < ApplicationController
  before_action :self_action , only:[:show,:destroy ,:edit ,:update]

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end
  def destroy
    
    session[:user_id] = nil
    @user.destroy
    redirect_to '/'
  end
  def create
    @user = User.create(user_params)
    if @user.save!
      session[:user_id] = @user.id
      redirect_to '/login'
    else
      redirect_to '/signup'
    end
  end
  def update 
      @user.update(user_params)
      redirect_to root_path
  end

private

  def user_params
    params.require(:user).permit(:f_name,:l_name,:user_name,:dob ,:sex,:dob,:age,:email_id, :password, :password_confirmation)
  end
  def self_action
    @user = User.find(params[:id])
  end
end
