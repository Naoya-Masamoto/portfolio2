class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  around_action :follow_user, only: %i[create]
  around_action :unfollow_user, only: %i[destroy]

  def create
    current_user.follow(@user)
  end

  def destroy
    current_user.unfollow(@user)
  end

  private

  def follow_user
    @user = User.find(params[:following_id])
    yield
  end

  def unfollow_user
    @user = User.find(params[:id])
    yield
  end
end
