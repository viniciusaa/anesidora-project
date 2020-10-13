class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :select_article
  before_action :private_article

  def index
    @comments = @article.comments.all
    @comment = current_user.comments.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article = @article
    if @comment.save
      flash[:notice] = "Comment published"
      redirect_to article_comments_path(@article)
    else
      flash[:alert] = "Failed to publish comment"
      redirect_to article_path(@article)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment was successfully deleted"
    redirect_to article_comments_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def select_article
    @article = Article.find(params[:article_id])
  end

  def private_article
    if @article.private == true
      unless @article.user == current_user || @article.contributors.include?(current_user)
        flash[:alert] = "Only the article owner or contributor can perform this action"
        redirect_to root_path
      end
    end
  end
end
