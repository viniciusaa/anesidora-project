class Article < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 40 }

  belongs_to :user
  has_many :article_bodies, dependent: :destroy
end
