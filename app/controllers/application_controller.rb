class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_logged, if: :require_login?

  def login_user
    User.find(session[:userid])
  end

  private

  def require_login?
    controller_name != "login"
  end

  def check_logged
    return if session[:userid].present?
    flash[:error] = t("error.not_logged_in")
    redirect_to root_path
  end
end
