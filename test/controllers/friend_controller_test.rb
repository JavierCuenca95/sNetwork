require 'test_helper'

class FriendControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get friend_show_url
    assert_response :success
  end

end
