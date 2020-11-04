class Privacy
  def self.toggle_privacy(article)
    if article.private
      article.private = false

      if article.save
        flash[:notice] = "Article is now public, all users will be able to see it"
        redirect_to article_path(article)
      end
    else
      article.private = true

      if article.save
        flash[:notice] = "Article is now private, only the owner and contributors will be able to see it"
        redirect_to article_path(article)
      end
    end
  end
end
