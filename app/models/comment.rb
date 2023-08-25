class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence: true
  validates :commenter, presence: true
end
