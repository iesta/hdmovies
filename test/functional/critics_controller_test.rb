require 'test_helper'

class CriticsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:critics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create critic" do
    assert_difference('Critic.count') do
      post :create, :critic => critics(:one).attributes
    end

    assert_redirected_to critic_path(assigns(:critic))
  end

  test "should show critic" do
    get :show, :id => critics(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => critics(:one).to_param
    assert_response :success
  end

  test "should update critic" do
    put :update, :id => critics(:one).to_param, :critic => critics(:one).attributes
    assert_redirected_to critic_path(assigns(:critic))
  end

  test "should destroy critic" do
    assert_difference('Critic.count', -1) do
      delete :destroy, :id => critics(:one).to_param
    end

    assert_redirected_to critics_path
  end
end
