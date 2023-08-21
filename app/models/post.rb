# frozen_string_literal: true

class Post < ApplicationRecord
  self.per_page = 10

  belongs_to :topic, optional: true
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_and_belongs_to_many :tags

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  accepts_nested_attributes_for :tags, reject_if: :all_blank, update_only: true

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates_associated :tags

  # Attributes title:string, body:text, topic_id:integer
end
