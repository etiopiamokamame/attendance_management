class HolidaysController < ApplicationController
  before_action :required_admin_authority

  def index
    @holidays = Holiday.where(deleted: false)
  end

  def new
    @holiday = Holiday.new
  end

  def create
    @holiday = Holiday.new(holiday_params)
    if @holiday.save
      flash[:notice] = t("success.process")
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def edit
    @holiday = Holiday.find(params[:id])
  end

  def update
    @holiday = Holiday.find(params[:id])
    @holiday.attributes = holiday_params
    if @holiday.save
      flash[:notice] = t("success.process")
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def destroy
    holiday = Holiday.find(params[:id])
    holiday.deleted = true
    holiday.save
    flash[:notice] = t("success.delete")
    redirect_to action: :index
  end

  private

  def holiday_params
    params.require(:holiday).permit(:name, :date)
  end
end
