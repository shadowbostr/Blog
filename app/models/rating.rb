class Rating < ApplicationRecord
  belongs_to :post
  validates :value, presence: true, numericality: { only_integer: true, in: 1..5 }
end
