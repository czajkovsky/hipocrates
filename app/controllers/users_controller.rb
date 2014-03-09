class UsersController < ApplicationController

  expose(:users)
  expose(:user, attributes: :permitted_params)

  def create
    if user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def update
    if user.save
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    redirect_to users_path
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :surname)
  end

end
