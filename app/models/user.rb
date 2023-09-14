class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Associations
  has_many :posts
  has_many :comment
  has_and_belongs_to_many :read_posts, class_name: 'Post', join_table: 'posts_users_read_status', inverse_of: :read_posts  # For post read status
  # for user comment rating
  has_many :comment_ratings
  has_many :rated_comments, through: :comment_ratings, source: :comment

  # validation
  validates :username, presence: true, length: {maximum: 20}

end
