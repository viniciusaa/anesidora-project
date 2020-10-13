class SubComment < ApplicationRecord
  validates :body, presence: true, length: { minimum: 4, maximum: 500 }

  belongs_to :article
  belongs_to :user
  belongs_to :comment
end
