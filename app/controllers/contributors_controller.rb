class ContributorsController < ApplicationController
  before_action :authenticate_user!
  before_action :select_article_and_user, only: [:update, :destroy]
  before_action :require_same_user, except: [:index]

  def index
    @article = Article.find(params[:article_id])
    @users = User.all.reject { |user| user == current_user || @article.contributors.include?(user)}
  end

  def update
    if @article.contributors << @user
      flash[:notice] = "Contributor added"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to add contributor"
      redirect_to article_path(@article)
    end
  end

  def destroy
    contribution = Contribution.where(user_id: @user.id, article_id: @article.id).first
    contribution.destroy
    flash[:notice] = "#{@user.first_name} is no longer a contributor"
    redirect_to article_path(@article)
  end

  def select_article_and_user
    @user = User.find(params[:id])
    @article = Article.find(params[:article_id])
  end

  def require_same_user
    if @article.user != current_user
      flash[:alert] = "Only the article owner can perform this action"
      redirect_to root_path
    end
  end
end
