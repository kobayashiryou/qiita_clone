# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many:articles, dependent: :destroy
  has_many:likes, dependent: :destroy
  has_many:comments, dependent: :destroy
  validates :nickname, uniqueness: true
  validates :email, :nickname, :password, presence: true
  validates :password, length: { in: 8..32 }
end
