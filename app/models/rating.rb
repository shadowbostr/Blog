class Rating < ApplicationRecord

  # Associations
  belongs_to :post

  # Validations
  validates :value, presence: true, numericality: { only_integer: true, in: 1..5 }
end
