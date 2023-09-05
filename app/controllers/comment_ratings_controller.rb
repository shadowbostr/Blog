# app/controllers/comment_ratings_controller.rb
class CommentRatingsController < ApplicationController
  before_action :set_comment


  def create
    @comment_rating = current_user.comment_ratings.build(comment_rating_params)
    @comment_rating.comment = @comment
    respond_to do |format|
     if @comment_rating.save
      format.json { render :show, status: :created, location: @post }
      format.js
     else
      format.json { render json: @post.errors, status: :unprocessable_entity }
      format.js
     end
    end

  end


  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end


    def comment_rating_params
      params.require(:comment_rating).permit(:rating)
    end

end