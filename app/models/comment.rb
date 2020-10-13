class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 4, maximum: 500 }

  has_many :sub_comments
  belongs_to :article
  belongs_to :user
end
