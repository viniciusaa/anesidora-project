class Article < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 4, maximum: 40 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :article_bodies, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions, class_name: "User"
end
