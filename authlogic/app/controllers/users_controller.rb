class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new, status: 422
    end
  end

  private

  # Strong parameters to permit the necessary attributes for user registration
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end
end
