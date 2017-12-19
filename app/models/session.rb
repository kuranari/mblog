class Session < ActiveModelSerializers::Model
  attr_reader :user
  attr_reader :api_token

  def initialize(user)
    @user = user
    @api_token = user.api_token
  end
end
