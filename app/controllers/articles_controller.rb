# frozen_string_literal: true
class ArticlesController < ApplicationController
  before_action :required_admin_authority
  before_action :check_create_article_params, only: [:new]
  before_action :check_update_article_params, only: [:edit]

  def index
    @articles = Article.availability.order_new
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    if request.get?
      today    = Date.today
      end_date = CONSTANTS::DEFAULT_POSTED_PERIOD.month.from_now
      @article = Article.new
      @article.posted_start_date_text = today.strftime(I18n.t(:date_format))
      @article.posted_end_date_text   = end_date.strftime(I18n.t(:date_format))
    else
      @article.save
      flash[:notice] = t(".create_article")
      redirect_to articles_path
    end
  end

  def edit
    if request.get?
      @article = Article.find(params[:id])
    else
      @article.save
      flash[:notice] = t(".update_article")
      redirect_to articles_path
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.update(deleted: "1")
    article.save
    flash[:notice] = t(".delete_article")
    redirect_to articles_path
  end

  private

  def check_create_article_params
    return if params[:article].blank?
    @article = Article.new(article_params)
    return if @article.valid?
    render action: :new
  end

  def check_update_article_params
    return if params[:article].blank?
    @article = Article.find(params[:id])
    @article.attributes = article_params
    return if @article.valid?
    render action: :edit
  end

  def article_params
    params.require(:article).permit(
      :user_id,
      :posted_start_date_text,
      :posted_end_date_text,
      :title,
      :body
    )
  end
end
