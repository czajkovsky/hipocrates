class UsersController < ApplicationController

  expose(:all_users) { User.all.decorate }
  expose(:patients) { User.patients.decorate }
  expose(:user, attributes: :permitted_params)
  expose(:relative) { user.relative || Relative.new }


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
    params.require(:user).permit(:name, :surname, :PESEL, :NIP, :date_of_birth, :place_of_birth, :street, :city, :postal_code, :id_number, :id_serial, :phone, :NIP, :email, :role_id, speciality_ids: [], relative: [:name, :surname, :phone])
  end

end
