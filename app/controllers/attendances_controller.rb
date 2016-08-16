class AttendancesController < ApplicationController
  before_action :prep_index_info, only: [:index, :prev_month, :next_month]

  def index
    today       = Date.today
    year        = params[:year]  || today.year
    month       = params[:month] || today.month
    date        = Date.new(year.to_i, month.to_i, 1)
    @attendance = @user.designated_month_attendance(date.year, date.month)
  end

  def prev_month
    year        = params[:year]
    month       = params[:month]
    date        = Date.new(year.to_i, month.to_i, 1) - 1.month
    @attendance = @user.designated_month_attendance(date.year, date.month)
    render action: :index
  end

  def next_month
    year        = params[:year]
    month       = params[:month]
    date        = Date.new(year.to_i, month.to_i, 1) + 1.month
    @attendance = @user.designated_month_attendance(date.year, date.month)
    render action: :index
  end

  def save
    @user           = User.find(params[:user][:id])
    options         = {}
    options[:year]  = attendance_params[:year]
    options[:month] = attendance_params[:month]
    @attendance     = @user.attendances.find_or_initialize_by(options)
    @attendance.attributes = attendance_params
    if @attendance.save
      flash[:notice] = t("success.process")
      redirect_to attendances_path(options)
    else
      @sys = SystemConfig.first
      render action: :index
    end
  end

  def export
    user            = User.find(params[:id])
    options         = {}
    options[:year]  = params[:year]
    options[:month] = params[:month]
    attendance      = user.attendances.find_by(options)

    excel = Excel::ExcelFile.create_attendance_excel(attendance)
    file  = Tempfile.new("attendance.xlsx", CONSTANTS::TEMP_DIR)
    excel.package.serialize file.path

    options  = [user.number, attendance.entries_abbr_era_year, user.name]
    filename = attendance.class.human_attribute_name(:excel_filename) % options
    send_file file.path,
      filename: filename,
      type:     "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  end

  private

  def attendance_params
    params.require(:attendance).permit(
      :year,
      :month,
      :display_site_start_time,
      :display_site_end_time,
      display_details: [:holiday_flag,
                        :week,
                        :work_start_time,
                        :work_end_time,
                        :time_holiday,
                        :leave_type_id,
                        :rest_out_of_standard]
    )
  end

  def prep_index_info
    @sys         = SystemConfig.first
    @user        = User.find(params[:id] || session[:userid])
    @leave_types = LeaveType.availability
  end
end
