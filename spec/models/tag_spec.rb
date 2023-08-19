require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    it 'should have and belong to many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end
  end

  describe 'validations' do
    it 'should validate the minimum length of name' do
      tag = Tag.new(name: 'A')
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include('is too short (minimum is 2 characters)')
    end

    it 'should validate the uniqueness of name' do
      existing_tag = Tag.create(name: 'Tag1')
      tag = Tag.new(name: 'Tag1')
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include('has already been taken')
    end
  end
end
