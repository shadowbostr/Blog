# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :topic, optional: true
  has_many :comments, dependent: :destroy
  validates :title, presence: true

  # Attributes title:string, body:text, topic_id:integer
end
