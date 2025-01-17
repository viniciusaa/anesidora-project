class ContributorsController < ApplicationController
  require "will_paginate/array"
  before_action :authenticate_user!
  before_action :set_article
  before_action :set_user, except: [:index]
  before_action :require_same_user, except: [:destroy]
  before_action :require_same_user_or_contributor, only: [:destroy]

  def index
    @users = User.all.select { |user|
      user != current_user && @article.contributors.exclude?(user)
    }.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    contribution = Contribution.find_by(user_id: @user.id, article_id: @article.id)
    contribution.destroy
    flash[:notice] = "#{@user.first_name} is no longer a contributor"
    redirect_to articles_path
  end

  def add_contributor_to_article
    if @article.contributors << @user
      flash[:notice] = "Contributor added"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to add contributor"
      redirect_to article_path(@article)
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if @article.user != current_user
      flash[:alert] = "Only the article owner can perform this action"
      redirect_to root_path
    end
  end

  def require_same_user_or_contributor
    unless @article.user == current_user || @user == current_user
      flash[:alert] = "Only the article owner can perform this action"
      redirect_to root_path
    end
  end
end
