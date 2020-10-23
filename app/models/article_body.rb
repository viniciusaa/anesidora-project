class ArticleBody < ApplicationRecord
  validates :body, presence: true, length: { minimum: 4, maximum: 10000 }
  validates :article_id, presence: true

  has_rich_text :body

  default_scope -> { order(created_at: :desc) }

  belongs_to :article
end
