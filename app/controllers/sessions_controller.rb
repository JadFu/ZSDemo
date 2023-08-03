# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.find_by(email: params[:user][:email])
  
      if @user && @user.authenticate(params[:user][:password])
        # User is authenticated, store the necessary data in cookies
        cookies[:user_email] = @user.email
        cookies[:user_address] = @user.address
        cookies[:user_tax_id] = @user.tax_id
  
        redirect_to items_path, notice: 'Login successful!'
      else
        # Invalid email or password, show error message
        flash.now[:alert] = 'Invalid email or password'
        render :new
      end
    end

    def destroy
        cookies.delete(:user_email)
        cookies.delete(:user_address)
        cookies.delete(:user_tax_id)
        
        redirect_to root_path, notice: 'Logged out successfully!'
    end
  end
  