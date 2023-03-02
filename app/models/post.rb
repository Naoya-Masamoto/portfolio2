class Post < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  belongs_to :color
  belongs_to :shape

  mount_uploader :img, ImageUploader
  mount_uploader :video, VideoUploader

  def editable_by?(user)
    user && user == self.user
  end
end
