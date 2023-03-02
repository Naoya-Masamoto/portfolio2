module PostsHelper
  def edit_post_link(post)
    if post.editable_by?(current_user)
        link_to '編集', edit_post_path(post)
    end
  end

  def delete_post_link(post)
    if post.user == current_user
      link_to '削除', post_path(post), method: :delete, data: { confirm: '本当に削除しますか？' }
    end
  end
end

