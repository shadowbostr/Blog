class CommentsController < ApplicationController
  before_action :set_comment, except: [:create]

  def show
    @comment_ratings = @comment.comment_ratings.includes(:user)
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
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

  def edit
    authorize! :update, @comment
    @comment = Comment.find(params[:id])
  end

  def update
    authorize! :update, @comment
    respond_to do |format|
      if @comment.update(comment_params)

        format.html { redirect_to post_url(@comment.post), notice: "Your comment was successfully updated." }
        format.json { render :'posts/show', status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end



  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit( :commenter, :content)
  end
end