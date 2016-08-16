class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_logged, if: :require_login?

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from Exception, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Forbidden, with: :render_403

  def login_user
    User.find(session[:userid])
  end

  def required_admin_authority
    unless session[:admin_user]
      flash[:error] = t("error.not_exist_admin")
      redirect_to top_index_path
    end
  end

  def render_500(e = nil)
    log_backtrace e
    render template: "errors/error_500", status: 500
  end

  def render_404(e = nil)
    log_backtrace e
    render template: "errors/error_404", status: 404
  end

  def render_403(e = nil)
    log_backtrace e
    render template: "errors/error_403", status: 403
  end

  private

  def log_backtrace(e = nil)
    return if e.blank?
    logger.info "#{CONSTANTS::LOGGER_PREFIX} #{e.message}"
    e.backtrace.each do |msg|
      logger.info "#{CONSTANTS::LOGGER_PREFIX} #{msg}"
    end
  end

  def require_login?
    controller_name != "login"
  end

  def check_logged
    return if session[:userid].present?
    flash[:error] = t("error.not_logged_in")
    redirect_to root_path
  end
end
