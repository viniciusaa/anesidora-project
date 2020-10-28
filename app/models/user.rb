class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }

  has_many :articles, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :collaborations, through: :contributions, class_name: "Article"
  has_many :comments, dependent: :destroy
  has_many :sub_comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
