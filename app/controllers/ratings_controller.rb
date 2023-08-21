# app/controllers/ratings_controller.rb
class RatingsController < ApplicationController
  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to @rating.post, notice: "Rating was successfully saved."
    else
      redirect_to @rating.post, alert: "Error saving rating."
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value, :post_id)
  end
end
