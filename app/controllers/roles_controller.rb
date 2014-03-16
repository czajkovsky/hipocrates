class RolesController < ApplicationController

  before_filter :authenticate_admin!

  expose(:roles)
  expose(:role, attributes: :permitted_params)

  def create
    if role.save
      redirect_to roles_path
    else
      render :new
    end
  end

  def update
    if role.save
      redirect_to roles_path
    else
      render :edit
    end
  end

  def destroy
    role.destroy
    redirect_to roles_path
  end

  private

  def permitted_params
    params.require(:role).permit(:name)
  end

end
