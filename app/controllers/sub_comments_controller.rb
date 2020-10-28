class SubCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article
  before_action :set_comment, except: [:destroy]
  before_action :private_article

  def new
    @subcomment = current_user.sub_comments.new
  end

  def create
    @subcomment = current_user.sub_comments.new(sub_comment_params)
    @subcomment.article = @article
    @subcomment.comment = @comment
    if @subcomment.save
      flash[:notice] = "Comment published"
      redirect_to article_comments_path(@article)
    else
      flash[:alert] = "Failed to publish comment"
      redirect_to article_comments_path(@article)
    end
  end

  def destroy
    @subcomment = SubComment.find(params[:id])
    if @subcomment.user != current_user && @article.user != current_user
      flash[:alert] = "Only the article owner can perform this action"
      redirect_to root_path
    else
      @subcomment.destroy
      flash[:notice] = "Comment was successfully deleted"
      redirect_to article_comments_path(@article)
    end
  end

  private

  def sub_comment_params
    params.require(:sub_comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def private_article
    if @article.private && (@article.user != current_user && @article.contributors.exclude?(current_user))
      flash[:alert] = "Only the article owner or contributor can perform this action"
      redirect_to root_path
    end
  end
end
