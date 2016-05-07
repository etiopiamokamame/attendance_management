class TopController < ApplicationController

  def index
    @user = login_user
  end
end
