class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Handle successful sign-up (e.g., redirect to a dashboard)
      redirect_to item_path, notice: 'Sign up successful!'
    else
      # Handle sign-up validation errors
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :address, :tax_id)
  end
end
