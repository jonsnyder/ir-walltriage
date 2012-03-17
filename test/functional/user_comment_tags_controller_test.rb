require 'test_helper'

class UserCommentTagsControllerTest < ActionController::TestCase
  setup do
    @user_comment_tag = user_comment_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_comment_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_comment_tag" do
    assert_difference('UserCommentTag.count') do
      post :create, user_comment_tag: @user_comment_tag.attributes
    end

    assert_redirected_to user_comment_tag_path(assigns(:user_comment_tag))
  end

  test "should show user_comment_tag" do
    get :show, id: @user_comment_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_comment_tag
    assert_response :success
  end

  test "should update user_comment_tag" do
    put :update, id: @user_comment_tag, user_comment_tag: @user_comment_tag.attributes
    assert_redirected_to user_comment_tag_path(assigns(:user_comment_tag))
  end

  test "should destroy user_comment_tag" do
    assert_difference('UserCommentTag.count', -1) do
      delete :destroy, id: @user_comment_tag
    end

    assert_redirected_to user_comment_tags_path
  end
end
