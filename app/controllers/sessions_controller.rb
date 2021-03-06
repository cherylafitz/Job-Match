class SessionsController < ApplicationController
  def new
    render layout: false
  end

  def create
    user = User.authenticate(params[:user][:email],params[:user][:password])
    if user
      session[:user_id] = user.id
      flash[:success] = 'You are now logged in. Welcome.'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid email or password. If you do not have an account, click the "create account" link.'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'You are now logged out. Sorry to see you go.'
    redirect_to root_path
  end
end
