class TopController < ApplicationController

  def index
    @new_articles = Article.availability.order_new
  end
end
