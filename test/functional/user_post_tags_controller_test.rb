require 'test_helper'

class UserPostTagsControllerTest < ActionController::TestCase
  setup do
    @user_post_tag = user_post_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_post_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_post_tag" do
    assert_difference('UserPostTag.count') do
      post :create, user_post_tag: @user_post_tag.attributes
    end

    assert_redirected_to user_post_tag_path(assigns(:user_post_tag))
  end

  test "should show user_post_tag" do
    get :show, id: @user_post_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_post_tag
    assert_response :success
  end

  test "should update user_post_tag" do
    put :update, id: @user_post_tag, user_post_tag: @user_post_tag.attributes
    assert_redirected_to user_post_tag_path(assigns(:user_post_tag))
  end

  test "should destroy user_post_tag" do
    assert_difference('UserPostTag.count', -1) do
      delete :destroy, id: @user_post_tag
    end

    assert_redirected_to user_post_tags_path
  end
end
