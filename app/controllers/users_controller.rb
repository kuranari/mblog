class UsersController < ApplicationController
  skip_before_action :authenticate, only: :create
  def create
    user = User.new(user_params)

    if user.save
      render json: Session.new(user)
    else
      render json: { message: user.errors.full_messages.join("\n") }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
