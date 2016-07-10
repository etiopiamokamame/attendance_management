class HolidaysController < ApplicationController

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
  end

  def update
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
