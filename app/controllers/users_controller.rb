class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.reject { |article|
      article.private == true unless
      @user == current_user || article.contributors.include?(current_user)
    }
    @contributions = @user.doings.reject { |article|
      article.private == true unless
      @user == current_user || article.contributors.include?(current_user)
    }
  end

  def index
    @users = User.all.paginate(page: params[:page], per_page: 5)
  end
end
