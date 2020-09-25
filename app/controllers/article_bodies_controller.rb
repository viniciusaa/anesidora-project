class ArticleBodiesController < ApplicationController
  before_action :authenticate_user!
  before_action :select_article_body, except: [:new, :create]
  before_action :select_article
  before_action :require_user_or_contributor

  def new
    @article_body = @article.article_bodies.new
  end

  def create
    @article_body = @article.article_bodies.build(article_body_params)
    if @article_body.save
      flash[:notice] = "Body has been created"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to create body"
      render "new"
    end
  end

  def edit; end

  def update
    @article_body = @article.article_bodies.build(article_body_params)
    if @article_body.save
      flash[:notice] = "Created new article body version"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to create new version"
      render "edit"
    end
  end

  def destroy
    @article_body.destroy
    flash[:notice] = "Body version was successfully deleted"
    redirect_to article_path(@article)
  end

  private

  def article_body_params
    params.require(:article_body).permit(:body, :article_id)
  end

  def select_article_body
    @article_body = ArticleBody.find(params[:id])
  end

  def select_article
    @article = Article.find(params[:article_id])
  end

  def require_user_or_contributor
    unless @article.user == current_user || @article.contributors.include?(current_user)
      flash[:alert] = "Only the article owner or contributor can perform this action"
      redirect_to root_path
    end
  end
end
