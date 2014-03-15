class UsersController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:new, :create]

  expose(:all_users) { User.all.decorate }
  expose(:user, attributes: :permitted_params)
  expose(:relative) { user.relative || Relative.new }

  expose(:patients) { User.by_role(:patient).decorate }
  expose(:admins) { User.by_role(:admin).decorate }
  expose(:nurses) { User.by_role(:nurse).decorate }
  expose(:office_stuff) { User.by_role(:office).decorate }
  expose(:doctors) { User.by_role(:doctor).decorate }

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
    params.require(:user).permit(:name, :surname, :pesel, :password, :nip, :date_of_birth, :place_of_birth, :street, :city, :postal_code, :id_number, :id_serial, :phone, :NIP, :email, :role_id, speciality_ids: [], relative: [:name, :surname, :phone])
  end

end
