# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { Post.create(title: 'Test Post', body: 'This is a test post.', topic_id: nil) }
  describe "associations" do
    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association).to_not be_nil
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe "validations" do
    it 'requires commenter and content presence' do
      comment = post.comments.new
      expect(comment).to_not be_valid
      expect(comment.errors[:content]).to include("can't be blank")
      expect(comment.errors[:commenter]).to include("can't be blank")
    end
  end

  describe "Comments" do

    let!(:comment) { Comment.create(post: post, commenter: 'user', content: "Test comment content.") }

    it "can be read" do
      expect(comment.commenter).to eq( 'user' )
      expect(comment.content).to eq( 'Test comment content.' )
    end
  end
end
