class Comment < ApplicationRecord

  # Associations
  belongs_to :post, counter_cache: true
  belongs_to :user
  # for user comment rating
  has_many :comment_ratings
  has_many :rated_by_users, through: :comment_ratings, source: :user

  #validattions
  validates :content, presence: true
  validates :commenter, presence: true


end
