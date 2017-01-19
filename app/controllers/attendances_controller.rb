# frozen_string_literal: true
class AttendancesController < ApplicationController
  before_action :check_save_attendance,        only: [:save]
  before_action :check_save_attendance_params, only: [:save]

  def index
    @attendances = current_user.fiscal_year_attendances
    @date        = @attendances.find(&:active_month?).date_ym
  end

  def save
    if request.get?
      @reasons       = Reason.availability
      @system_config = SystemConfig.first
      if @attendance.blank?
        @attendance                      = Attendance.new
        @attendance.user_id              = current_user.id
        @attendance.date_ym              = params[:date]
        @attendance.site_start_time_text = @system_config.base_working_start_time_text
        @attendance.site_end_time_text   = @system_config.base_working_end_time_text
        @attendance.rest_start_time_text = @system_config.rest_start_time_text
        @attendance.rest_end_time_text   = @system_config.rest_end_time_text
      end
    else
      @attendance.save
      flash[:notice] = t(".save_attendance")
      redirect_to attendances_path
    end
  end

  def specific_month
    user_id     = current_user.id
    @date       = params[:date]
    @attendance = Attendance.find_by(user_id: user_id, date_ym: @date)
    return unless @attendance.blank?
    system_config                    = SystemConfig.first
    @attendance                      = Attendance.new
    @attendance.user_id              = current_user.id
    @attendance.date_ym              = params[:date]
    @attendance.site_start_time_text = system_config.base_working_start_time_text
    @attendance.site_end_time_text   = system_config.base_working_end_time_text
    @attendance.rest_start_time_text = system_config.rest_start_time_text
    @attendance.rest_end_time_text   = system_config.rest_end_time_text
  end

  private

  def check_save_attendance
    return if request.post?
    if params[:id].blank?
      return if Util::DateUtil.valid?(params[:date], t(:default_date_format_ym, separate: nil))
    else
      @attendance = Attendance.find_by(id: params[:id])
      return unless @attendance.blank?
    end
    raise ActionController::RoutingError, t("errors.no_route", path: request.fullpath)
  end

  def check_save_attendance_params
    return if request.get?
    @attendance            = Attendance.find_by(id: params[:id]) || Attendance.new
    @attendance.attributes = attendance_params
    return if @attendance.valid?
    @system_config = SystemConfig.first
    render action: :save
  end

  def attendance_params
    params.require(:attendance).permit(:user_id,
                                       :date_ym,
                                       :site_start_time_text,
                                       :site_end_time_text,
                                       :rest_start_time_text,
                                       :rest_end_time_text,
                                       attendance_details: [
                                         :week,
                                         :holiday_flag,
                                         :work_start_time_text,
                                         :work_end_time_text,
                                         :working_time_text,
                                         :off_hours_time_text,
                                         :late_night_time_text,
                                         :time_holiday_text,
                                         :shortfall_time_text,
                                         :reason,
                                         :leave_type,
                                         :rest_out_of_standard_text
                                       ])
  end
end
