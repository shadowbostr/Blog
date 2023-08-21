class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if params.key?(:topic_id)
      @topic = Topic.find( params[:topic_id] )
      @posts = @topic.posts.paginate(page: params[:page])
    else

      @posts = Post.includes(:topic).paginate(page: params[:page])
    end

  end

  # GET /posts/1 or /posts/1.json
  def show
    @rating = @post.ratings.build
    @ratings_by_value = @post.ratings.group( :value ).count
  end

  # GET /posts/new
  def new

    @topic = Topic.find( params[:topic_id])
    @post = @topic.posts.new
    @tag = @post.tags.build
  end

  # GET /posts/1/edit
  def edit

    @tag = @post.tags.build

  end

  # POST /posts or /posts.json
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(post_params)


    respond_to do |format|
      if @post.save

        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)

        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    topic_id = @post.topic_id
    @post.destroy

    respond_to do |format|
      format.html { redirect_to params.key?(:topic_id) ? topic_path(Topic.find(topic_id)) : posts_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if params.key?(:topic_id)
        @topic = Topic.find( params[:topic_id])
        @post = @topic.posts.find(params[:id])
      else
        @post = Post.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, tags_attributes: [ :id, :name ], tag_ids: [] )
    end
end
