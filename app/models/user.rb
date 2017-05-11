class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessible :nick, :name, :last_name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar

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

  def getPosts1
    @posts = Array.new
    @friends = friends

    @friends.each do |friend|
      friend.posts.all.each do |post|
        @posts.push(post)
      end
    end

    posts.all.each do |post| 
      @posts.push(post)
    end

    @posts.sort_by(&:created_at)
    #@posts.order({ created_at: :desc })
    #@posts.sort_by { |m| [m.created_at, m.updated_at].max }.reverse!

    return @posts
  end

  def getPosts2
    @posts = Post.order(created_at: :desc)

    @returned_posts = Array.new
    @posts.each do |post|
      if post.user.friends_with?(self) or post.user == self
        @returned_posts.push(post)
      end
    end

    return @returned_posts
  end



  mount_uploader :avatar, AvatarUploader

  validates_integrity_of  :avatar
  validates_processing_of :avatar
  

  has_many :notifications, dependent: :destroy 
end
