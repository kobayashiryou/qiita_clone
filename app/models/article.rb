class Article < ApplicationRecord
<<<<<<< HEAD
  belongs_to :user
  has_many :likes
  has_many :comments
  dependent: :destroy
=======
  belongs_to:user
  has_many:like, dependent: :destroy
  has_many:comment, dependent: :destroy
>>>>>>> 9060f4e (dependent: :destroyの編集)
end
