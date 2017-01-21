# frozen_string_literal: true
class ReasonsController < ApplicationController
  before_action :required_admin_authority
  before_action :prep_reasons,               only: [:index, :change_orders]
  before_action :check_create_reason_params, only: [:new]
  before_action :check_update_reason_params, only: [:edit]

  def new
    if request.get?
      @reason = Reason.new
    else
      @reason.save
      flash[:notice] = t(".create_reason")
      redirect_to reasons_path
    end
  end

  def edit
    if request.get?
      @reason = Reason.find(params[:id])
    else
      @reason.save
      flash[:notice] = t(".update_reason")
      redirect_to reasons_path
    end
  end

  def destroy
    Reason.find(params[:id]).soft_delete
    flash[:notice] = t(".delete_reason")
    redirect_to reasons_path
  end

  def update_orders
    reason = Reason.availability.find(params[:id])
    reason.change_order(params[:position])
    render json: { result: true }
  end

  private

  def prep_reasons
    @reasons = Reason.order_display
  end

  def check_create_reason_params
    return if params[:reason].blank?
    @reason = Reason.new(reason_params)
    return if @reason.valid?
    render action: :new
  end

  def check_update_reason_params
    return if params[:reason].blank?
    @reason = Reason.find(params[:id])
    @reason.attributes = reason_params
    return if @reason.valid?
    render action: :edit
  end

  def reason_params
    params.require(:reason).permit(:content)
  end
end
