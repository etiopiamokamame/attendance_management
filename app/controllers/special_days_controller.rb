# frozen_string_literal: true
class SpecialDaysController < ApplicationController
  before_action :required_admin_authority
  before_action :check_create_special_day_params, only: [:new]
  before_action :check_update_special_day_params, only: [:edit]

  def index
    @special_days = SpecialDay.availability
  end

  def new
    if request.get?
      @special_day = SpecialDay.new
    else
      @special_day.save
      flash[:notice] = t(".create_special_day")
      redirect_to special_days_path
    end
  end

  def edit
    if request.get?
      @special_day = SpecialDay.find(params[:id])
    else
      @special_day.save
      flash[:notice] = t(".update_special_day")
      redirect_to special_days_path
    end
  end

  def destroy
    SpecialDay.find(params[:id]).soft_delete
    flash[:notice] = t(".delete_special_day")
    redirect_to special_days_path
  end

  private

  def check_create_special_day_params
    return if params[:special_day].blank?
    @special_day = SpecialDay.new(special_day_params)
    return if @special_day.valid?
    render action: :new
  end

  def check_update_special_day_params
    return if params[:special_day].blank?
    @special_day = SpecialDay.find(params[:id])
    @special_day.attributes = special_day_params
    return if @special_day.valid?
    render action: :edit
  end

  def special_day_params
    params.require(:special_day).permit(
      :name,
      :date_text,
      :day_type
    )
  end
end
