require 'test_helper'

class MalletCommandsControllerTest < ActionController::TestCase
  setup do
    @mallet_command = mallet_commands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mallet_commands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mallet_command" do
    assert_difference('MalletCommand.count') do
      post :create, mallet_command: @mallet_command.attributes
    end

    assert_redirected_to mallet_command_path(assigns(:mallet_command))
  end

  test "should show mallet_command" do
    get :show, id: @mallet_command
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mallet_command
    assert_response :success
  end

  test "should update mallet_command" do
    put :update, id: @mallet_command, mallet_command: @mallet_command.attributes
    assert_redirected_to mallet_command_path(assigns(:mallet_command))
  end

  test "should destroy mallet_command" do
    assert_difference('MalletCommand.count', -1) do
      delete :destroy, id: @mallet_command
    end

    assert_redirected_to mallet_commands_path
  end
end
