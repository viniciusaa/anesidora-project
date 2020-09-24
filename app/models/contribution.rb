class Contribution < ApplicationRecord
  belongs_to :contributor, class_name: "User", foreign_key: 'user_id'
  belongs_to :doing, class_name: "Article", foreign_key: 'article_id'
end
