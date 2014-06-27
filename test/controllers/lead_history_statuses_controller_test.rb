require 'test_helper'

class LeadHistoryStatusesControllerTest < ActionController::TestCase
  setup do
    @lead_history_status = lead_history_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lead_history_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lead_history_status" do
    assert_difference('LeadHistoryStatus.count') do
      post :create, lead_history_status: { color: @lead_history_status.color, name: @lead_history_status.name, progress: @lead_history_status.progress }
    end

    assert_redirected_to lead_history_status_path(assigns(:lead_history_status))
  end

  test "should show lead_history_status" do
    get :show, id: @lead_history_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lead_history_status
    assert_response :success
  end

  test "should update lead_history_status" do
    patch :update, id: @lead_history_status, lead_history_status: { color: @lead_history_status.color, name: @lead_history_status.name, progress: @lead_history_status.progress }
    assert_redirected_to lead_history_status_path(assigns(:lead_history_status))
  end

  test "should destroy lead_history_status" do
    assert_difference('LeadHistoryStatus.count', -1) do
      delete :destroy, id: @lead_history_status
    end

    assert_redirected_to lead_history_statuses_path
  end
end
