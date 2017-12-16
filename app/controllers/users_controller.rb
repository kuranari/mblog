class UsersController < ApplicationController
  skip_before_action :authenticate, only: :create

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)

    if user.save
      response.headers["X-Api-Token"] = user.api_token
      render json: user
    else
      render json: { message: user.errors.full_messages.join("\n") }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
