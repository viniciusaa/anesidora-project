class ArticleBody < ApplicationRecord
  validates :body, presence: true, length: { minimum: 4, maximum: 10000 }
  default_scope -> { order(created_at: :desc) }

  def version
    self.article.article_bodies.reverse.index(self) + 1
  end

  belongs_to :article
end
