class Comment < ApplicationRecord

  # Associations
  belongs_to :post, counter_cache: true
  belongs_to :user

  #validattions
  validates :content, presence: true
  validates :commenter, presence: true


end
