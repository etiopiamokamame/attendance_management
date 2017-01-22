# frozen_string_literal: true
class LeaveTypesController < ApplicationController
  before_action :required_admin_authority
  before_action :prep_leave_types,               only: [:index, :change_orders]
  before_action :check_create_leave_type_params, only: [:new]
  before_action :check_update_leave_type_params, only: [:edit]

  def new
    if request.get?
      @leave_type = LeaveType.new
    else
      @leave_type.save
      flash[:notice] = t(".create_leave_type")
      redirect_to leave_types_path
    end
  end

  def edit
    if request.get?
      @leave_type = LeaveType.find(params[:id])
    else
      @leave_type.save
      flash[:notice] = t(".update_leave_type")
      redirect_to leave_types_path
    end
  end

  def destroy
    LeaveType.find(params[:id]).soft_delete
    flash[:notice] = t(".delete_leave_type")
    redirect_to leave_types_path
  end

  def update_orders
    leave_type = LeaveType.availability.find(params[:id])
    leave_type.change_order(params[:position])
    render json: { result: true }
  end

  private

  def prep_leave_types
    @leave_types = LeaveType.order_display
  end

  def check_create_leave_type_params
    return if params[:leave_type].blank?
    @leave_type = LeaveType.new(leave_type_params)
    return if @leave_type.valid?
    render action: :new
  end

  def check_update_leave_type_params
    return if params[:leave_type].blank?
    @leave_type = LeaveType.find(params[:id])
    @leave_type.attributes = leave_type_params
    return if @leave_type.valid?
    render action: :edit
  end

  def leave_type_params
    params.require(:leave_type).permit(:content,
                                       :status,
                                       :aggregate_display)
  end
end
