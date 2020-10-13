class Article < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 4, maximum: 40 }
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }

  belongs_to :user
  has_many :article_bodies, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions, class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :sub_comments, dependent: :destroy
end
