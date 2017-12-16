class ApplicationController < ActionController::Base
  before_action :authenticate

  def current_user
    @current_user
  end

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by(api_token: token)
    end
  end
end
