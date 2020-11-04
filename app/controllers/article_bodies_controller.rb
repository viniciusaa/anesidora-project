class ArticleBodiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article_body, except: [:new, :create]
  before_action :set_article
  before_action :require_user_or_contributor, except: [:show, :make_stable]
  before_action :require_user, only: [:make_stable]
  before_action :define_body, only: [:create, :update]

  def show; end

  def new
    @article_body = @article.article_bodies.new
  end

  def create
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

  def make_stable
    Stability.switch_stable_body(@article, @article_body)
    flash[:notice] = "Version #{@article_body.version} is now the stable"
    redirect_to article_path(@article)
  end

  private

  def article_body_params
    params.require(:article_body).permit(:body, :article_id)
  end

  def set_article_body
    @article_body = ArticleBody.find(params[:id])
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def require_user_or_contributor
    unless @article.user == current_user || @article.contributors.include?(current_user)
      flash[:alert] = "Only the article owner or contributor can perform this action"
      redirect_to root_path
    end
  end

  def require_user
    unless @article.user == current_user
      flash[:alert] = "Only the article owner can perform this action"
      redirect_to root_path
    end
  end

  def define_body
    @article_body = @article.article_bodies.new(article_body_params)
    @article_body.updater = current_user.full_name
    @article.body_count += 1
    @article.save
    @article_body.version = @article.body_count
  end
end
