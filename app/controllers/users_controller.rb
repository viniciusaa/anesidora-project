class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:article_page], per_page: 3)
    @contributions = @user.doings.paginate(page: params[:contribution_page], per_page: 3)
  end

  def index
    @users = User.all.paginate(page: params[:page], per_page: 5)
  end
end
