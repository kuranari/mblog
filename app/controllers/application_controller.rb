class ApplicationController < ActionController::Base
  before_action :authenticate

  def current_user
    @current_user
  end

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token|
      @current_user = User.find_by(api_token: token)
    end
  end

  def render_unauthorized
    render json: { message: 'token invalid' }, status: :unauthorized
  end
end
