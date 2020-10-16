class Comment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 2, maximum: 500 }

  has_many :sub_comments, dependent: :destroy
  belongs_to :article
  belongs_to :user
end
