class UserMailer < ApplicationMailer

  def welcome_email
    @user = current_user
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Ruby Blogger')
  end
end
