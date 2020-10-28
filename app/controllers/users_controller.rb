class UsersController < ApplicationController
  require "will_paginate/array"
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    @articles = @user.articles.select { |article|
      article.user == current_user  || article.contributors.include?(current_user) || !article.private
    }.paginate(page: params[:articles_page], per_page: 5)

    @contributions = @user.collaborations.select { |article|
      article.user == current_user  || article.contributors.include?(current_user) || !article.private
    }.paginate(page: params[:contributions_page], per_page: 5)
  end

  def index
    @users = User.all.paginate(page: params[:page], per_page: 5)
  end
end
