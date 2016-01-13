require 'test_helper'

class SubsitiesControllerTest < ActionController::TestCase
  setup do
    @subsity = subsities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subsities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subsity" do
    assert_difference('Subsity.count') do
      post :create, subsity: { name: @subsity.name }
    end

    assert_redirected_to subsity_path(assigns(:subsity))
  end

  test "should show subsity" do
    get :show, id: @subsity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subsity
    assert_response :success
  end

  test "should update subsity" do
    patch :update, id: @subsity, subsity: { name: @subsity.name }
    assert_redirected_to subsity_path(assigns(:subsity))
  end

  test "should destroy subsity" do
    assert_difference('Subsity.count', -1) do
      delete :destroy, id: @subsity
    end

    assert_redirected_to subsities_path
  end
end
