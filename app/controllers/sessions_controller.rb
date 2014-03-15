class SessionsController < ApplicationController

  expose(:user)

  def create
    user = User.authenticate(params[:user][:pesel], params[:user][:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      redirect_to log_in_path, notice: 'Password or email invalid'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end

end



