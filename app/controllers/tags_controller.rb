class TagsController < ApplicationController
  before_action :set_tags, only: [ :show, :destroy ]
  def index
    @tags = Tag.all
  end

  def show
    @posts = @tag.posts.all
    render 'posts/index'
  end

  def create
    tag_name = params[:tag][:name]
    # Logic to create a new tag with the tag_name
    Tag.create(name: tag_name)
    redirect_to tags_path
  end

  def update

  end

  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to  tags_path, notice: "Tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private

  def set_tags
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
