require 'test_helper'

class LdaTopicsControllerTest < ActionController::TestCase
  setup do
    @lda_topic = lda_topics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lda_topics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lda_topic" do
    assert_difference('LdaTopic.count') do
      post :create, lda_topic: @lda_topic.attributes
    end

    assert_redirected_to lda_topic_path(assigns(:lda_topic))
  end

  test "should show lda_topic" do
    get :show, id: @lda_topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lda_topic
    assert_response :success
  end

  test "should update lda_topic" do
    put :update, id: @lda_topic, lda_topic: @lda_topic.attributes
    assert_redirected_to lda_topic_path(assigns(:lda_topic))
  end

  test "should destroy lda_topic" do
    assert_difference('LdaTopic.count', -1) do
      delete :destroy, id: @lda_topic
    end

    assert_redirected_to lda_topics_path
  end
end
