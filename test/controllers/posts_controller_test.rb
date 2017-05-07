require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should log in to create a post" do
    post create: , post: {contenido: "Hello world"}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end


  test "Should show new page when a user logs in" do
    sign_in users(:luis)
    get :new
    assert_response :success
  end

  test "should create post" do
    sign_in users(:luis)
    assert_difference('Post.count') do
      post posts_url, params: { post: { contenido: @post.contenido} }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { contenido: @post.contenido } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
