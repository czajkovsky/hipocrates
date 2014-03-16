class ApplicationController < ActionController::Base

  helper_method :current_user, :office?, :nurse?, :doctor?, :admin?, :patient?
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

  def authenticate_nurse!
    redirect_to root_path unless nurse?
  end

  def authenticate_doctor!
    redirect_to root_path unless doctor?
  end

  def authenticate_admin!
    redirect_to root_path unless admin?
  end

  def authenticate_med_stuff!
    redirect_to root_path unless (doctor? or nurse? or office?)
  end

  def patient?
    current_user && (current_user.is?(:patient) or admin?)
  end

  def office?
    current_user && (current_user.is?(:office) or admin?)
  end

  def nurse?
    current_user && (current_user.is?(:nurse) or admin?)
  end

  def doctor?
    current_user && (current_user.is?(:doctor) or admin?)
  end

  def admin?
    current_user && current_user.is?(:admin)
  end

end
