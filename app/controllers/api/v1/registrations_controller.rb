class Api::V1::RegistrationsController < Api::V1::BaseController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
  end
end
