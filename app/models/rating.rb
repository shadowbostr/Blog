class Rating < ApplicationRecord

  # Associations
  belongs_to :post

  # callbacks
  after_save :update_post_rating_average
  after_destroy :update_post_rating_average


  # Validations
  validates :value, presence: true, numericality: { only_integer: true, in: 1..5 }

  private
  def update_post_rating_average
    puts "update_post_rating_average method called"
    post.set_rating_average
  end

end
