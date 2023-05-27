class VoteHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  
  def create
    @vote_history = VoteHistory.new(vote_params)
    if @vote_history.save
      redirect_to @post, notice: '投票しました'
    else
      redirect_to @post, alert: 'すでに投票済みです'
    end
  end

  def destroy
    @vote_history = VoteHistory.find(params[:id])
    if @vote_history.destroy
      redirect_to @post, notice: '投票を取り消しました。'
    else
      redirect_to @post, alert: '投票の取り消しに失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def vote_params
    params.require(:vote_history).permit(:vote_type).merge(post: @post, user: current_user)
  end

end
