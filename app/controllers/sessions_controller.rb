class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    login(session_params[:email], session_params[:password]) do |user, error|
      if error
        render json: { message: error }, status: :unauthorized
      else
        response.headers["X-Api-Token"] = user.api_token
        render json: user
      end
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
