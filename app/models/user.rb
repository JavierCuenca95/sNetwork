class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessible :nick, :name, :last_name, :email, :password, :password_confirmation

  has_many :posts, dependent: :destroy

  validates :nick, presence: true, uniqueness: true, format: {
  	#with: /a-zA-Z0-9_-/,
    with: /[a-zA-Z0-9]+/,
  	message: 'Nick has an incorrect format'
  } 
  validates :name, presence: true 
  validates :last_name, presence: true 

  has_friendship
  acts_as_voter


  after_create :assign_default_role

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end
  
end
