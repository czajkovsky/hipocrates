class ApplicationController < ActionController::Base

  helper_method :current_user, :office?, :doctor?, :admin?, :patient?, :stuff?
  before_filter :authenticate_user!

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to log_in_path unless current_user
  end

  def authenticate_office!
    redirect_to root_path unless office?
  end

  def authenticate_doctor!
    redirect_to root_path unless doctor?
  end

  def authenticate_admin!
    redirect_to root_path unless admin?
  end

  def authenticate_stuff!
    redirect_to root_path unless stuff?
  end

  def authenticate_patient!
    redirect_to root_path unless patient?
  end

  def stuff?
    office? or doctor? or admin?
  end

  def patient?
    current_user && current_user.is?(:patient)
  end

  def office?
    current_user && current_user.is?(:office)
  end

  def doctor?
    current_user && current_user.is?(:doctor)
  end

  def admin?
    current_user && current_user.is?(:admin)
  end

end
