class ArticlesController < ApplicationController
  require "will_paginate/array"
  before_action :authenticate_user!
  before_action :set_article, except: [:new, :create, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy, :change_privacy]

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      flash[:notice] = "Article has been created"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to create article"
      render "new"
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article has been updated"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to updated article"
      render "new"
    end
  end

  def index
    @articles = Article.all.select { |article|
      article.user == current_user || article.contributors.include?(current_user) || !article.private
    }.paginate(page: params[:page], per_page: 5)
  end

  def show
    if @article.private && (@article.user != current_user && @article.contributors.exclude?(current_user))
      flash[:alert] = "Only the article owner or contributor can perform this action"
      redirect_to root_path
    end

    @contributors = @article.contributors.paginate(page: params[:page], per_page: 5)

    @article_bodies = @article.article_bodies.paginate(page: params[:page], per_page: 5)

    stable = @article.article_bodies.where(stable_version: true).first
    if stable
      @stable_body_version = stable
    else
      @stable_body_version = @article.article_bodies.first
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully deleted"
    redirect_to articles_path
  end

  def change_privacy
    Privacy.toggle_privacy(@article)
    flash[:notice] = "Article privacy updated"
    redirect_to article_path(article)
  end

  private

  def article_params
    params.require(:article).permit(:name, :user_id, :private)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if @article.user != current_user
      flash[:alert] = "Only the article owner can perform this action"
      redirect_to root_path
    end
  end
end
