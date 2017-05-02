class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessible :nick, :name, :last_name, :email, :password, :password_confirmation

  has_many :posts

  validates :nick, presence: true, uniqueness: true, format: {
  	with: /a-zA-Z0-9_-/,
  	message: '.must'
  } 
  validates :name, presence: true 
  validates :last_name, presence: true 
end
