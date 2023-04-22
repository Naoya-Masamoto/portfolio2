class SearchController < ApplicationController

  def index
    @q = params[:q]
    if @q.present?
      # ユーザーの検索
      @users = User.where('username LIKE ?', "%#{@q}%")
      # ポストの検索
      @posts = Post.where('title LIKE ? OR body LIKE ?', "%#{@q}%", "%#{@q}%")
      # ポストに対するブランドの検索
      @posts += Post.joins(:brand).where('brands.name LIKE ?', "%#{@q}%")
      # 投稿を作成日時(created_at)で並び替える
      @posts = @posts.sort_by(&:created_at).reverse
    end
    @search_results = (@users + @posts).uniq
  end
end