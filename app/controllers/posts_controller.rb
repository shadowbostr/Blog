class PostsController < ApplicationController
  before_action :set_post, except: %i[index create new  ]
  # GET /posts or /posts.json
  def index
    # Checking date range
    if params[:from_date].present? && params[:to_date].present?
      from_date = Date.parse(params[:from_date])
      to_date = Date.parse(params[:to_date])
    else
      from_date = Date.yesterday
      to_date = Date.today
    end
    # getting current user's read posts
    @read_statuses = current_user.read_posts.select(:id).to_a if current_user.present?

    if params.key?(:topic_id) # getting posts of particular topic
      @topic = Topic.find(params[:topic_id])
      @posts = @topic.posts.includes(:user).filter_by_date_range(from_date, to_date).paginate(page: params[:page])

    elsif params.key?(:tag_id) # getting posts which belongs to particular tag
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.includes(:topic, :user).filter_by_date_range(from_date, to_date).paginate(page: params[:page])

    else # getting all posts
      @posts = Post.includes(:topic, :user).filter_by_date_range(from_date, to_date).paginate(page: params[:page])
    end


  end

  # GET /posts/1 or /posts/1.json
  def show
    @rating = @post.ratings.build
    @ratings_by_value = @post.ratings.group(:value).count
    @comments = @post.comments
  end

  # GET /posts/new
  def new

    @topic = Topic.find( params[:topic_id])
    @post = @topic.posts.new
    @tag = @post.tags.new

    respond_to do |format|

      format.html # Render the HTML template
      format.js   # Render JavaScript to update the container
    end

  end

  # GET /posts/1/edit
  def edit
    authorize! :update, @post
    @tag = @post.tags.build

  end

  # POST /posts or /posts.json
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save

         format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
         format.json { render :show, status: :created, location: @post }
         format.js

      else
         format.html { render :new, status: :unprocessable_entity }
         format.json { render json: @post.errors, status: :unprocessable_entity }
         format.js

      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize! :update, @post
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
    authorize! :destroy, @post
    topic_id = @post.topic_id
    @post.destroy

    respond_to do |format|
      format.html { redirect_to params.key?(:topic_id) ? topic_path(Topic.find(topic_id)) : posts_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def mark_as_read
    unless current_user.read_posts.include?(@post)
      current_user.read_posts << @post
    end
    respond_to do |format|
      format.js { render js: "console.log('post marked as read')"  }
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
      params.require(:post).permit(:title, :body, :image, tags_attributes: %i[id name], tag_ids: [] )
    end
end
