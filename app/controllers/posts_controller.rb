class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @user = @post.user
  end

  def brand
    @brand = Brand.find(params[:id]) #ここでクリックしたカテゴリIDを取得
    #@post = Post.includes(:brands).where(post_brand_relations: { brand_id: @brand })
    @posts = @brand.post.order(created_at: :desc)
  end

  def shape
    @shape = Shape.find(params[:id]) 
    #@post = Post.includes(:shapes).where(post_shape_relations: { shape_id: @shape })
    @posts = @shape.post.order(created_at: :desc)
  end

  def color
    @color = Color.find(params[:id]) 
    #@post = Post.includes(:colors).where(post_colors_relations: { color_id: @color })
    @posts = @color.post.order(created_at: :desc)
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
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :img, :video, :brand_id, :shape_id, :color_id).merge(user_id:current_user.id)
  end
end
