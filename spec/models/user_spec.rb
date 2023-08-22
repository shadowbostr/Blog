# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Devise authentication' do
    it 'is valid with valid attributes' do
      user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end

    it 'can sign in with valid credentials' do
      user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      sign_in_result = user.valid_password?('password')
      expect(sign_in_result).to be_truthy
    end

    it 'cannot sign in with invalid credentials' do
      user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      sign_in_result = user.valid_password?('wrong_password')
      expect(sign_in_result).to be_falsy
    end
  end
end
