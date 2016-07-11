class LeaveTypesController < ApplicationController
  before_action :required_admin_authority

  def index
    @leave_types = LeaveType.all.order(:id)
  end

  def new
    @leave_type = LeaveType.new
  end

  def create
    # TODO
    # 文字数のバリデートを仕組む予定
    LeaveType.create(leave_type_params)
    flash[:notice] = t("success.process")
    redirect_to action: :index
  end

  def edit
    @leave_type = LeaveType.find(params[:id])
  end

  def update
    leave_type = LeaveType.find(params[:id])
    leave_type.update_attributes(leave_type_params)
    # TODO
    # 文字数のバリデートを仕組む予定
    flash[:notice] = t("success.process")
    redirect_to action: :index
  end

  def destroy
    LeaveType.find(params[:id]).destroy
    flash[:notice] = t("success.delete")
    redirect_to action: :index
  end

  private

  def leave_type_params
    params.require(:leave_type).permit(:content)
  end
end
