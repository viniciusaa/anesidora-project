class ContributorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @article = Article.find(params[:article_id])
    @users = User.all.reject { |user| user == current_user || @article.contributors.include?(user)}
  end

  def update
    @user = User.find(params[:id])
    @article = Article.find(params[:article_id])

    if @article.contributors << @user
      flash[:notice] = "Contributor added"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to add contributor"
      redirect_to article_path(@article)
    end
  end
end
