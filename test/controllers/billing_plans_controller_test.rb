require 'test_helper'

class BillingPlansControllerTest < ActionController::TestCase
  setup do
    @billing_plan = billing_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:billing_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create billing_plan" do
    assert_difference('BillingPlan.count') do
      post :create, billing_plan: { company_id: @billing_plan.company_id, name: @billing_plan.name, status: @billing_plan.status, tax_rate: @billing_plan.tax_rate }
    end

    assert_redirected_to billing_plan_path(assigns(:billing_plan))
  end

  test "should show billing_plan" do
    get :show, id: @billing_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @billing_plan
    assert_response :success
  end

  test "should update billing_plan" do
    patch :update, id: @billing_plan, billing_plan: { company_id: @billing_plan.company_id, name: @billing_plan.name, status: @billing_plan.status, tax_rate: @billing_plan.tax_rate }
    assert_redirected_to billing_plan_path(assigns(:billing_plan))
  end

  test "should destroy billing_plan" do
    assert_difference('BillingPlan.count', -1) do
      delete :destroy, id: @billing_plan
    end

    assert_redirected_to billing_plans_path
  end
end
