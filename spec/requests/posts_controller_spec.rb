require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:topic) { Topic.create( name: 'Test topic') }
  describe "GET #index" do

    it "assigns @posts to list posts of specific topic" do

      post1 = topic.posts.create(title:'Test post1', body: 'Testing controller')
      post2 = topic.posts.create(title:'Test post2', body: 'Testing controller')
      get :index, params: { topic_id: topic.id }
      expect(assigns(:posts)).to eq([post1, post2])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it 'returns the status code 200' do
      get :index
      expect(response).to have_http_status(200)
    end

  end

  describe "GET #show" do
    let(:post) {  topic.posts.create(title:'Test post4', body: 'Testing controller')}
    it "assigns @post" do
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end

    it "renders the show template" do
      get :show, params: { id: post.id }
      expect(response).to render_template(:show)
    end

    it 'returns the status code 200' do
      get :show,  params: { id: post.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    it "assigns @topic and @post" do
      get :new, params: { topic_id: topic.id }
      expect(assigns(:topic)).to eq(topic)
      expect(assigns(:post)).to be_a_new(Post)
    end

    it "renders the new template" do
      get :new, params: { topic_id: topic.id }
      expect(response).to render_template(:new)
    end
  end

  describe "PATCH #update" do
    let(:post) { topic.posts.create(title:'Test post5', body: 'Testing controller') }
    it "updates the post" do
      patch :update, params: { id: post.id, post: { title: "New Title", body: "Testing prpose", topic_id: topic.id } }
      post.reload
      expect(post.title).to eq("New Title")
    end

    it "redirects to the updated post" do
      patch :update, params: { id: post.id, post: { title: "New Title", body: "Testing prpose", topic_id: topic.id }  }
      expect(response).to redirect_to(assigns(:post))
    end

    it 'returns the status code 302' do
      get :update, params: { id: post.id, post: { title: "New Title", body: "Testing prpose", topic_id: topic.id }  }
      expect(response).to have_http_status(302)
    end

  end

  describe "DELETE #destroy" do
    let!(:post) { topic.posts.create(title:'Test post7', body: 'Testing controller') }
    it "destroys the post" do
      expect { delete :destroy, params: { id: post.id } }.to change(Post, :count).by(-1)
    end

    it "redirects to the topic page" do
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(topic_path(post.topic))
    end

    it 'returns the status code 302' do
      delete :destroy,  params: { id: post.id }
      expect(response).to have_http_status(302)
    end

  end

end






