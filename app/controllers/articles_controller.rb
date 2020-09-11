class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :select_article, except: [:new, :create, :index]

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
    @articles = current_user.articles
  end

  def show
    @article_bodies = @article.article_bodies.paginate(page: params[:page], per_page: 1) if @article.article_bodies.any?
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
end
