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

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  accepts_nested_attributes_for :tags, reject_if: :all_blank, update_only: true


  # validations
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates_associated :tags

  def avg_rating
    return 0 if ratings.empty?
    ratings.average(:value).round(1)
  end

end
