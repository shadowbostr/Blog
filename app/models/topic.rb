# frozen_string_literal: true

class Topic < ApplicationRecord

  # Associations
  has_many :posts, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true

  # Attributes: name:string
end
