class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show]

  def show; end

  private

  def set_user
    @user = User.find(current_user.id)
  end
end