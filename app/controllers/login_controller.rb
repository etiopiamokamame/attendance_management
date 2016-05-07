class LoginController < ApplicationController
  layout false

  def index
  end

  def authenticate
    if user = User.find_by(login_params)
      session[:userid]     = user.id
      session[:admin_user] = user.admin
      redirect_to top_index_path
    else
      flash[:error] = I18n.t("error.not_login")
      redirect_to action: :index
    end
  end

  private

  def login_params
    params.require(:user).permit(:number, :password)
  end
end
