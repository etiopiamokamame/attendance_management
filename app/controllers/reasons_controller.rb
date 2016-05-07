class ReasonsController < ApplicationController
  def index
    @reasons = Reason.all.order(:id)
  end

  def new
    @reason = Reason.new
  end

  def create
    # TODO
    # 文字数のバリデートを仕組む予定
    Reason.create(reason_params)
    flash[:notice] = t("success.process")
    redirect_to action: :index
  end

  def edit
    @reason = Reason.find(params[:id])
  end

  def update
    reason = Reason.find(params[:id])
    # TODO
    # 文字数のバリデートを仕組む予定
    reason.update_attributes(reason_params)
    flash[:notice] = t("success.process")
    redirect_to action: :index
  end

  def destroy
    Reason.find(params[:id]).destroy
    flash[:notice] = t("success.delete")
    redirect_to action: :index
  end

  private

  def reason_params
    params.require(:reason).permit(:content)
  end
end
