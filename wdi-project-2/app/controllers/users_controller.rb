class UsersController < ApplicationController


  def index
    if current_user.resume
      resume = current_user.resume

      @resume_array = string_to_arr resume
      @things = words_to_hash @words
      gon.resume = @things
    end
  end
    # render :json => @data
    # @data = result.first
  # end
  def new
    @user = User.new
  end

  def edit
  end

  def create
    user = User.authenticate(params[:user][:email],params[:user][:password])
      @user = User.create user_params
    if user
      flash[:danger] = 'You already have an account. Please sign in.'
      redirect_to login_path
    # can't prevent people from creating nil accounts
    elsif @user.errors.any?
      flash[:danger] = @user.errors.full_messages.uniq.to_sentence
      render :new
    else
      user = User.authenticate(params[:user][:email],params[:user][:password])
      session[:user_id] = @user.id
      flash[:success] = 'You have created an account, and are now logged in.'
      redirect_to root_path
    end
  end

  def update
    @current_user.resume = params[:user][:resume]
    @current_user.save

    redirect_to users_path
  end



  private

  def user_params
    params.require(:user).permit(:email,:password,:name)
  end

end
