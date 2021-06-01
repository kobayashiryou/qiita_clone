# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
<<<<<<< HEAD
  has_many :articles
  has_many :likes
  has_many :comments
  dependent: :destroy
=======
  has_many:articles, dependent: :destroy
  has_many:likes, dependent: :destroy
  has_many:comments, dependent: :destroy
>>>>>>> 9060f4e (dependent: :destroyの編集)
end
