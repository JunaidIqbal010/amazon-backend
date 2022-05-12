class Api::V1::AuthenticationController < Api::V1::BaseController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: @user.as_json(only: [:username, :email]).merge({token: token})
    else
      render json: { error: "unauthorized"}, status: :unauthorized
    end
  end

  def sign_up
    @user = User.create!(registration_params)
    token = jwt_encode(user_id: @user.id)
    render json: @user.as_json(only: [:username, :email]).merge({token: token})
  end

  private
    def registration_params
      params.permit(:username, :email, :password)
    end
end