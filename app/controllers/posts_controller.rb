class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
     redirect_to @post
    else
     render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      flash[:notice] = "投稿を削除しました。"
      redirect_to root_path
    else
      flash[:alert] = "投稿を削除できませんでした。"
      redirect_to root_path
    end
  end

  def likes
    @like_posts = current_user.like_posts.includes(:user).order(created_at: :desc)
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :img, :video, :brand_id, :shape_id, :color_id).merge(user_id:current_user.id)
  end
end
