class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :body, :status, presence: true
  enum status: { draft: "draft", published: "published" }
end
