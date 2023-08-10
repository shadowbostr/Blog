# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'belongs to a topic (optional)' do
      association = described_class.reflect_on_association(:topic)
      expect(association).to_not be_nil
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:optional]).to eq(true)
    end
  end

  describe 'validations' do
    it 'requires title presence' do
      post = Post.new
      expect(post).to_not be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end
  end

  describe 'attributes' do
    it 'has expected database columns' do
      expect(described_class.column_names).to include('title')
      expect(described_class.column_names).to include('body')
      expect(described_class.column_names).to include('topic_id')
    end

    it 'has correct data types for attributes' do
      expect(described_class.columns_hash['title'].type).to eq(:string)
      expect(described_class.columns_hash['body'].type).to eq(:text)
      expect(described_class.columns_hash['topic_id'].type).to eq(:integer)
    end
  end

  end


