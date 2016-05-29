class ArticlesController < ApplicationController

  def index
    @articles = Article.where(deleted: false).order("updated_at DESC")
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    today    = Date.today

    @article.user_id         = session[:userid]
    @article.registered_date = today.strftime("%Y%m%d")
    @article.updated_date    = today.strftime("%Y%m%d")

    if @article.save
      flash[:notice] = t("success.process")
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def update
    @article              = Article.find(params[:id])
    @article.attributes   = article_params
    today                 = Date.today
    @article.user_id      = session[:userid]
    @article.updated_date = today.strftime("%Y%m%d")

    if @article.save
      flash[:notice] = t("success.process")
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
