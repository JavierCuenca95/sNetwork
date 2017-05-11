class Post < ApplicationRecord
	attr_accessible :contenido, :user_id
	belongs_to :user
	validates :contenido, presence: true, length: {minimum: 5}
	validates :user_id, presence: true


	resourcify
	acts_as_votable


	has_many :post_attachments
   	accepts_nested_attributes_for :post_attachments

   	has_many :notifications, dependent: :destroy 
end
