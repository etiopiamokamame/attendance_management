class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save!
    session[:userid] = @user.id
    flash[:notice]   = t("success.login", name: @user.name)
    redirect_to top_index_path
  rescue ActiveRecord::RecordInvalid
    render action: :new
  end

  private

  def user_params
    params.require(:user).permit( :name,
                                  :affiliation_name,
                                  :number,
                                  :password,
                                  :password_confirm)
  end
end
