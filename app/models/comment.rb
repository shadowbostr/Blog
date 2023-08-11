class Comment < ApplicationRecord
  belongs_to :post

  validates :content, presence: true
  validates :commenter, presence: true
end
