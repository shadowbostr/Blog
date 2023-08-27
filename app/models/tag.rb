class Tag < ApplicationRecord

  # Associations
  has_and_belongs_to_many :posts

  # Validations
  validates :name, length: { minimum: 2 }, uniqueness: true
end
