class UsersController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:register, :create]
  before_filter :authenticate_stuff!, except: [:register, :create]

  expose(:all_users) { User.all.decorate }
  expose(:user, attributes: :permitted_params)
  expose(:relative) { user.relative || Relative.new }

  expose(:patients) { User.by_role(:patient).decorate }
  expose(:admins) { User.by_role(:admin).decorate }
  expose(:office_stuff) { User.by_role(:office).decorate }
  expose(:doctors) { User.by_role(:doctor).decorate }

  def confirmation
    user.save
  end

  def create
    if user.save
      redirect_to root_path
    else
      if params[:user][:origin] == 'web_form'
        render :register
      else
        user.save(validate: false)
        redirect_to confirmation_user_path(user)
      end
    end
  end

  def update
    if user.save
      redirect_to users_path
    else
      user.save(validate: false)
      redirect_to confirmation_user_path(user)
    end
  end

  def destroy
    user.destroy
    redirect_to users_path
  end

  private

  def permitted_params
    params.require(:user).permit(:login, :name, :surname, :pesel, :password, :password_confirmation, :nip, :date_of_birth, :place_of_birth, :street, :sex, :city, :postal_code, :id_number, :id_serial, :phone, :NIP, :origin, :email, :role_id, speciality_ids: [], relative: [:name, :surname, :phone])
  end

end
