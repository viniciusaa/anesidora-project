class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }

  has_many :articles, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :doings, through: :contributions, class_name: "Article"

  default_scope -> { order(created_at: :desc) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
