class Article < ApplicationRecord
  belongs_to:user
  has_many:like, dependent: :destroy
  has_many:comment, dependent: :destroy
  validates :title, :body, presence: true
end
