class TopController < ApplicationController

  def index
    @new_articles = Article.availability.posted_period.order_new
  end
end
