# frozen_string_literal: true
class SystemConfigsController < ApplicationController
  before_action :required_admin_authority
  before_action :check_update_system_config_params, only: [:edit]

  def edit
    if request.get?
      @system_config = SystemConfig.first
    else
      @system_config.save
      flash[:notice] = t(".update_system_config")
      redirect_to edit_system_config_path
    end
  end

  private

  def check_update_system_config_params
    return if params[:system_config].blank?
    @system_config = SystemConfig.first
    @system_config.attributes = system_config_params
    return if @system_config.valid?
    render action: :edit
  end

  def system_config_params
    params.require(:system_config).permit(
      :company_name,
      :base_working_start_time_text,
      :base_working_end_time_text,
      :rest_start_time_text,
      :rest_end_time_text,
      :base_overtime_rest_start_time_text,
      :base_overtime_rest_end_time_text,
      :late_night_time_text,
      :time_off_hours_prospect,
      weeks: []
    )
  end
end
