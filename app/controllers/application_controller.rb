class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_logged, if: :require_login?

  def login_user
    User.find(session[:userid])
  end

  def required_admin_authority
    unless session[:admin_user]
      flash[:error] = t("error.not_exist_admin")
      redirect_to top_index_path
    end
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
