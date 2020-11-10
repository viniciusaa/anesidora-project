class ArticlePrivacy
  def initialize(article)
    @article = article
  end

  def toggle_privacy
    if @article.private
      @article.update(private: false)
    else
      @article.update(private: true)
    end
  end
end
