class CommentsController < ApplicationController
  before_action :set_post


  # POST /comments or /comments.json
  def create
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment was successfully created." }
        format.json { render 'posts/show', status: :created, location: @post }
      else
        format.html { redirect_to post_path(@post), notice: "Comment was not created" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit( :commenter, :content)
    end
end
