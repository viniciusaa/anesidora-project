class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :select_article, except: [:new, :create, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

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
    @articles = Article.all.paginate(page: params[:page], per_page: 5)
  end

  def show
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

  private

  def article_params
    params.require(:article).permit(:name, :user_id)
  end

  def select_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if @article.user != current_user
      flash[:alert] = "Only the article owner can perform this action"
      redirect_to root_path
    end
  end
end
