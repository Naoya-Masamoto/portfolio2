class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post), notice: "コメントしました。"
    else
      @post = @comment.post
      @comments = @post.comments.includes(:user)
      render "posts/show", alert: "コメントできませんでした。"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    redirect_to post_path(@comment.post), notice: "コメントを削除しました。"
  end

  private
  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
