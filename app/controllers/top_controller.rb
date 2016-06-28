class TopController < ApplicationController

  def index
    @new_articles = Article.all.order("updated_at DESC")
  end
end
