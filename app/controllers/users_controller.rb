class UsersController < ApplicationController
  skip_before_action :authenticate, only: :create
  def create
    user = User.new(user_params)

    if user.save
      render json: { api_token: user.api_token }
    else
      render json: { message: user.errors.full_messages.join("\n") }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
