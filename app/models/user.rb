class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :postings, :inverse_of => 'owner'
  has_many :reviews, :inverse_of => 'owner'
end
