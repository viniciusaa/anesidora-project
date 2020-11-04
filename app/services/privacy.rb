class Privacy
  def self.toggle_privacy(article)
    if article.private
      article.update(private: false)
    else
      article.update(private: true)
    end
  end
end
