require 'test_helper'

class LdaPostTopicsControllerTest < ActionController::TestCase
  setup do
    @lda_post_topic = lda_post_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lda_post_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lda_post_topic" do
    assert_difference('LdaPostTopic.count') do
      post :create, lda_post_topic: @lda_post_topic.attributes
    end

    assert_redirected_to lda_post_topic_path(assigns(:lda_post_topic))
  end

  test "should show lda_post_topic" do
    get :show, id: @lda_post_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lda_post_topic
    assert_response :success
  end

  test "should update lda_post_topic" do
    put :update, id: @lda_post_topic, lda_post_topic: @lda_post_topic.attributes
    assert_redirected_to lda_post_topic_path(assigns(:lda_post_topic))
  end

  test "should destroy lda_post_topic" do
    assert_difference('LdaPostTopic.count', -1) do
      delete :destroy, id: @lda_post_topic
    end

    assert_redirected_to lda_post_topics_path
  end
end
