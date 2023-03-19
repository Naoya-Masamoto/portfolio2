class Post < ApplicationRecord
  belongs_to :user,  optional: true
  belongs_to :brand
  belongs_to :color
  belongs_to :shape

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :img, ImageUploader
  mount_uploader :video, VideoUploader

  def editable_by?(user)
    user && user == self.user
  end

  #お気に入りのためのメソッド
  def liked_by(user)
    if user.present?
      Like.find_by(user_id: user.id, post_id: id)
    else
      nil
    end
  end
end
