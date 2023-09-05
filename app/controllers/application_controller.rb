class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'You are not authorized to perform the action'
  end

end
