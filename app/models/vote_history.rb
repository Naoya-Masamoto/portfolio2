class VoteHistory < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :vote_type, presence: true
  validates :post_id, uniqueness: { scope: :user_id }
end
