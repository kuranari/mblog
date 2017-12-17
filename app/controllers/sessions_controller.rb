class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    login(session_params[:email], session_params[:password]) do |user, error|
      if error
        render json: { message: error }, status: :unauthorized
      else
        render json: { api_token: user.api_token }
      end
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
