class RegistrationsController < ApplicationController
  skip_forgery_protection only: [:create]
  def create
    user = User.new(user_params)

    if user.save
      RegistrationMailer.welcome_email(user).deliver_now

      render json:{
        id: user.id,
        email: user.email,
        username: user.username
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :username, :password
    )
  end
end
