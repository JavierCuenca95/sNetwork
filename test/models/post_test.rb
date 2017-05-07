require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "A post must have content" do
  	post = Post.new
  	assert !post.save
  	assert !post.errors[:contenido].empty?
  end

  test "A post must have at least 5 characters" do
  	post = Post.new
  	post.contenido = "Hi"
  	assert !post.save
  	assert !post.errors[:contenido].empty?
  end

  test "A post must have an user" do
  	post = Post.new
  	post.contenido = "Hi world"
  	assert !post.save
  	assert !post.errors[:contenido].empty?
  end
end
