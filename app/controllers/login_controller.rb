# frozen_string_literal: true
class LoginController < ApplicationController
  before_action :redirect_logined, only: [:new]
  before_action :authenticate,     only: [:new]

  def new
    @user = User.new
  end

  def logout
    clear_current_user
    redirect_to root_path
  end

  private

  def redirect_logined
    return if current_user.blank?
    redirect_to top_index_path
  end

  def authenticate
    return if params[:user].blank?
    return if request.get?
    user = User.availability.find_by(user_params)
    if user.blank?
      flash.now[:alert] = t("errors.not_login")
      @user = User.new(user_params)
      render action: :new
    else
      self.current_user = user.id
      redirect_to top_index_path
    end
  end

  def user_params
    params.require(:user).permit(:number, :password)
  end
end
