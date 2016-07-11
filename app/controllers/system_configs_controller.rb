class SystemConfigsController < ApplicationController
  before_action :required_admin_authority
  before_action :prep_system_config, only: [:edit, :update]

  def update
    @sys.attributes = sys_params
    @sys.save!
    flash[:notice] = t("success.process")
    redirect_to action: :edit
  rescue ActiveRecord::RecordInvalid
    render action: :edit
  end

  private

  def prep_system_config
    @sys = SystemConfig.find(params[:id])
  end

  def sys_params
    params.require(:system_config).permit(
      :company_name,
      :base_working_start_time,
      :base_working_end_time,
      :rest_start_time,
      :rest_end_time,
      :enable_base_overtime_rest_time,
      :base_overtime_rest_start_time,
      :base_overtime_rest_end_time,
      :late_night_time,
      :time_off_hours_prospect
    )
  end
end
