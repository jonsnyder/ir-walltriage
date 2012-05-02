require 'test_helper'

class LdaTopicWordsControllerTest < ActionController::TestCase
  setup do
    @lda_topic_word = lda_topic_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lda_topic_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lda_topic_word" do
    assert_difference('LdaTopicWord.count') do
      post :create, lda_topic_word: @lda_topic_word.attributes
    end

    assert_redirected_to lda_topic_word_path(assigns(:lda_topic_word))
  end

  test "should show lda_topic_word" do
    get :show, id: @lda_topic_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lda_topic_word
    assert_response :success
  end

  test "should update lda_topic_word" do
    put :update, id: @lda_topic_word, lda_topic_word: @lda_topic_word.attributes
    assert_redirected_to lda_topic_word_path(assigns(:lda_topic_word))
  end

  test "should destroy lda_topic_word" do
    assert_difference('LdaTopicWord.count', -1) do
      delete :destroy, id: @lda_topic_word
    end

    assert_redirected_to lda_topic_words_path
  end
end
