# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_logged, if: :require_login?

  helper_method :current_user, :login_action?

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from Exception,                      with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404
  rescue_from Forbidden,                      with: :render_403

  def login_action?
    controller_name == "login"
  end

  def current_user
    return if session[:user_id].blank?
    @current_user ||= User.availability.find(session[:user_id])
  end

  def current_user=(id)
    user = User.availability.find_by(id: id)
    return if user.blank?
    session[:user_id] = user.id
    @current_user = user
  end

  def clear_current_user
    session[:user_id] = nil
  end

  def toggle_sidebar
    close_state             = "sidebar-collapse"
    session[:sidebar_state] = session[:sidebar_state] == close_state ? "" : close_state
  end

  def required_admin_authority
    return if current_user.admin?
    raise Forbidden
  end

  def render_500(e = nil)
    log_backtrace e
    flash.now[:alert] = t("errors.system_error")
    render template: "shares/error_500", status: 500
  end

  def render_404(e = nil)
    log_backtrace e
    flash.now[:alert] = t("errors.not_exist_page")
    render template: "shares/error_404", status: 404
  end

  def render_403(e = nil)
    log_backtrace e
    flash.now[:alert] = t("errors.not_exist_admin")
    render template: "shares/error_403", status: 403
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
    !login_action?
  end

  def check_logged
    return if current_user.present?
    flash[:alert] = t("errors.not_logged_in")
    redirect_to root_path
  end
end
