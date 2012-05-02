require 'test_helper'

class LdaPostTagsControllerTest < ActionController::TestCase
  setup do
    @lda_post_tag = lda_post_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lda_post_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lda_post_tag" do
    assert_difference('LdaPostTag.count') do
      post :create, lda_post_tag: @lda_post_tag.attributes
    end

    assert_redirected_to lda_post_tag_path(assigns(:lda_post_tag))
  end

  test "should show lda_post_tag" do
    get :show, id: @lda_post_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lda_post_tag
    assert_response :success
  end

  test "should update lda_post_tag" do
    put :update, id: @lda_post_tag, lda_post_tag: @lda_post_tag.attributes
    assert_redirected_to lda_post_tag_path(assigns(:lda_post_tag))
  end

  test "should destroy lda_post_tag" do
    assert_difference('LdaPostTag.count', -1) do
      delete :destroy, id: @lda_post_tag
    end

    assert_redirected_to lda_post_tags_path
  end
end
