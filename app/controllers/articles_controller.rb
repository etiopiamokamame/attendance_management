class ArticlesController < ApplicationController
  before_action :required_admin_authority

  def index
    @articles = Article.availability.order_new
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    today    = Date.today
    end_date = CONSTANTS::DEFAULT_POSTED_PERIOD.month.from_now
    @article = Article.new
    @article.posted_start_year  = today.year
    @article.posted_start_month = today.month
    @article.posted_start_day   = today.day
    @article.posted_end_year    = end_date.year
    @article.posted_end_month   = end_date.month
    @article.posted_end_day     = end_date.day
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
    params.require(:article).permit(:title,
                                    :body,
                                    :posted_start_date,
                                    :posted_end_date)
  end
end
