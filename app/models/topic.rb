# frozen_string_literal: true

class Topic < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy

  # Attributes: name:string
end
