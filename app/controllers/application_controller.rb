class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized
    render json: { message: 'You are not authorized to perform this action.' }, status: :unauthorized
  end
end
