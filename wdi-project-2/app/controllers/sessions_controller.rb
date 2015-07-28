class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:user][:email],params[:user][:password])
    if user
      session[:user_id] = user.id
      flash[:success] = 'You are now logged in.'
      redirect_to users_path
    else
      flash[:danger] = 'Invalid email or password. If you do not have an account, click the "create account" link.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'You are now logged out.'
    redirect_to login_path
  end


end
