# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
  
      if user&.password == params[:password]
        session[:user_id] = user.id
        session[:user_email] = user.email
        session[:user_address] = user.address
        session[:user_tax] = user.tax_id
        redirect_to root_path, notice: 'Logged in successfully.'
      else
        flash.now[:alert] = 'Invalid email or password.'
        render :new
      end
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'Logged out successfully.'
    end
  end
  
  