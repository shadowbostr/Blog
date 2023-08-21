class Rating < ApplicationRecord
  belongs_to :post
  validates :value ,  numericality: { greater_than: 0 , less_than: 6 }
end
