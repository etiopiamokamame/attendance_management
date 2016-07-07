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
    @article         = Article.new(article_params)
    @article.user_id = session[:userid]

    if @article.save
      flash[:notice] = t("success.process")
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def update
    @article            = Article.find(params[:id])
    @article.attributes = article_params
    @article.user_id    = session[:userid]

    if @article.save
      flash[:notice] = t("success.process")
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.deleted = true
    article.save
    flash[:notice] = t("success.delete")
    redirect_to action: :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
