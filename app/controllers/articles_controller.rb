class ArticlesController < ApplicationController
  before_action :authenticate_user!

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

  def index
    @articles = current_user.articles
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:name, :user_id)
  end
end
