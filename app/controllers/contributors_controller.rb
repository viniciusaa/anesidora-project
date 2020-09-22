class ContributorsController < ApplicationController
  before_action :authenticate_user!

  def show
    @article = Article.find(params[:article_id])
    @users = User.all.reject { |user| @article.contributors.include?(user.id) ||
                                      user == current_user }
  end

  def update
    @user = User.find(params[:id])
    @article = Article.find(params[:article_id])
    @article.contributors += [@user.id.to_s]

    if @article.save
      flash[:notice] = "Contributor added"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to add contributor"
      redirect_to article_path(@article)
    end
  end
end
