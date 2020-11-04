class Stability
  def self.switch_stable_body(article, article_body)
    article.article_bodies.where(stable_version: true).update(stable_version: false)
    article_body.update(stable_version: true)
  end
end
