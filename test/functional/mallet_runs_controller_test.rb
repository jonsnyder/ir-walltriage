require 'test_helper'

class MalletRunsControllerTest < ActionController::TestCase
  setup do
    @mallet_run = mallet_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mallet_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mallet_run" do
    assert_difference('MalletRun.count') do
      post :create, mallet_run: @mallet_run.attributes
    end

    assert_redirected_to mallet_run_path(assigns(:mallet_run))
  end

  test "should show mallet_run" do
    get :show, id: @mallet_run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mallet_run
    assert_response :success
  end

  test "should update mallet_run" do
    put :update, id: @mallet_run, mallet_run: @mallet_run.attributes
    assert_redirected_to mallet_run_path(assigns(:mallet_run))
  end

  test "should destroy mallet_run" do
    assert_difference('MalletRun.count', -1) do
      delete :destroy, id: @mallet_run
    end

    assert_redirected_to mallet_runs_path
  end
end
