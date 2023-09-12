# frozen_string_literal: true

class Topic < ApplicationRecord

  self.per_page = 10

  # Associations
  has_many :posts, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true

  # Attributes: name:string
end
