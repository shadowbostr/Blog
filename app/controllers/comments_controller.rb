require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    let!(:post) { Post.create(title: "Test Post", body: "This is a test post.") }

    context "with valid parameters" do
      it "creates a new comment" do
        expect {
          post :create, params: { post_id: post.id, comment: { commenter: "John", content: "Hello, world!" } }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the post's show page" do
        post :create, params: { post_id: post.id, comment: { commenter: "John", content: "Hello, world!" } }
        expect(response).to redirect_to(post_path(post))
      end
    end

    context "with invalid parameters" do
      it "does not create a new comment" do
        expect {
          post :create, params: { post_id: post.id, comment: { commenter: "", content: "" } }
        }.not_to change(Comment, :count)
      end

      it "redirects to the post's show page" do
        post :create, params: { post_id: post.id, comment: { commenter: "", content: "" } }
        expect(response).to redirect_to(post_path(post))
      end
    end
  end
end
