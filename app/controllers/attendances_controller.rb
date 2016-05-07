class AttendancesController < ApplicationController
  def index
    @sys        = SystemConfig.first
    @user       = login_user
    binding.pry
    @attendance = @user.this_month_attendance
  end

  def save
    @user       = User.find(params[:user][:id])
    @attendance = @user.attendances.find_or_initialize_by(
                    year:  attendance_params[:year],
                    month: attendance_params[:month]
                  )
    @attendance.attributes = attendance_params
    @attendance.save!
    flash[:notice] = t("success.process")
    redirect_to action: :index
  rescue ActiveRecord::RecordInvalid
    @sys = SystemConfig.first
    render action: :index
  end

  private

  def attendance_params
    my_params = params.require(:attendance).permit(
      :year,
      :month,
      :display_site_start_time,
      :display_site_end_time,
      details: {}
    )
    params[:attendance][:details].each do |key, val|
      my_params[:details][key] = params[:attendance][:details].require(key).permit(
        :week,
        :work_start_time_duration,
        :work_end_time_duration,
        :working_time_duration,
        :off_hours_time_duration,
        :late_night_time_duration,
        :time_holiday_duration,
        :shortfall_time_duration,
        :reason,
        :leave_type_id,
        :rest_out_of_standard_duration
      )
    end
    my_params
  end
end
