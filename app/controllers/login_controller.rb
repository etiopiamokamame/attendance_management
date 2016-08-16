class LoginController < ApplicationController
  layout false

  def index
    redirect_to top_index_path if session[:userid].present?
  end

  def logout
    session.delete(:userid)
    redirect_to root_path
  end

  def toggle_sidebar
    session[:hidden_sidebar] = session[:hidden_sidebar].blank?
    render nothing: true
  end

  def authenticate
    user = User.availability.find_by(number: params[:user][:number], password: params[:user][:password])
    if user.blank?
      flash[:error] = I18n.t("error.not_login")
      redirect_to action: :index
    else
      session[:userid]     = user.id
      session[:admin_user] = user.admin
      redirect_to top_index_path
    end
  end

  private

  def login_params
    params.require(:user).permit(:number, :password)
  end
end
