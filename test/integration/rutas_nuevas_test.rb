require 'test_helper'

class RutasNuevasTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "/login redirecciona a la página de inicio" do
  	get '/login'
  	assert_response :success
  end

  test "/logout redirecciona a la página de inicio" do
  	get '/logout'
  	assert_response :success
  end

  test "/signin redirecciona a la página de inicio" do
  	get '/signin'
  	assert_response :success
  end
end
