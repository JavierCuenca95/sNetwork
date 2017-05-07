require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "User created must have a name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:name].empty?
  end

  test "User created must have a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "User created must have a nick" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:nick].empty?
  end

  #test "User created must have a unique nick" do
  	#user = User.new
  	#user.nick = users(:luis).nick
  	#assert !user.save
  	#assert !user.errors[:nick].empty?
  #end

  test "User created must have a nick with a correct format" do
  	user = User.new
  	user.nick = "Bad nick"
  	assert !user.save
  	assert !user.errors[:nick].empty?
  	assert user.errors[:nick].include("Nick has an incorrect format")
  end

end
