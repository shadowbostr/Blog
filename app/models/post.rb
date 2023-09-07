# frozen_string_literal: true

class Post < ApplicationRecord
  # Attributes title:string, body:text, topic_id:integer

  self.per_page = 10

  # Associations
  belongs_to :topic, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :read_by_users, class_name: 'User', join_table: 'posts_users_read_status', inverse_of: :read_by_users # For post read status

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  accepts_nested_attributes_for :tags, reject_if: :all_blank, update_only: true


  # validations
  validates :title, presence: true, length: { in: 5..20 }
  validates :body, presence: true , length:{ minimum: 10 }
  validates_associated :tags

  def set_rating_average
    puts "before updation #{self.rating_average}"
    self.rating_average = ratings.average(:value).to_f.round(2)
    puts "after updation #{self.rating_average}"
    save
  end

  scope :filter_by_date_range, ->(from_date, to_date) {
    where(created_at: from_date.beginning_of_day..to_date.end_of_day)
  }

end
