class UserConfigsController < ApplicationController
  before_action :required_admin_authority

  def index
    @users = User.where.not(id: session[:userid]).order(:number)
  end

  def save
    User.change_admin(params[:user_configs])
    flash[:notice] = t("success.process")
    redirect_to action: :index
  end

  def init_password
    user = User.find(params[:id])
    user.init_password
    flash[:notice] = t("success.init_password", name: user.name)
    redirect_to action: :index
  end

  def destroy
    user = User.find(params[:id])
    user.remove
    flash[:notice] = t("success.remove_user", name: user.name)
    redirect_to action: :index
  end
end
