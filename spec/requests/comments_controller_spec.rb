require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    let!(:post) { Post.create(title: "Test Post", body: "This is a test post", topic_id: nil) }

    context "with valid attributes" do
      it "creates a new comment" do
        expect {
          post :create, params: { post_id: post.id, comment: { commenter: "Dhanush", content: "Test comment content." } }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the post" do
        post :create, params: { post_id: post.id, comment: { commenter: "John", content: "Test comment content." } }
        expect(response).to redirect_to(post_path(post))
      end
    end

    context "with invalid attributes" do
      it "does not create a new comment" do
        expect {
          post :create, params: { post_id: post.id, comment: { commenter: "John", content: nil } }
        }.to_not change(Comment, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { post_id: post.id, comment: { commenter: "John", content: nil } }
        expect(response).to render_template(:new)
      end
    end
  end
end
