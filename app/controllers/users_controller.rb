class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def liked_posts
    @liked_posts = current_user.like_posts.includes(:user).order(created_at: :desc)
  end

end
