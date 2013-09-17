require 'test_helper'

class TeacherOrdersControllerTest < ActionController::TestCase
  setup do
    @teacher_order = teacher_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teacher_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher_order" do
    assert_difference('TeacherOrder.count') do
      post :create, teacher_order: { invoice_flg: @teacher_order.invoice_flg, memo: @teacher_order.memo, memo: @teacher_order.memo, order_date: @teacher_order.order_date, payment_date: @teacher_order.payment_date, payment_flg: @teacher_order.payment_flg, payment_term: @teacher_order.payment_term, teacher_id: @teacher_order.teacher_id, unit_price: @teacher_order.unit_price }
    end

    assert_redirected_to teacher_order_path(assigns(:teacher_order))
  end

  test "should show teacher_order" do
    get :show, id: @teacher_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher_order
    assert_response :success
  end

  test "should update teacher_order" do
    patch :update, id: @teacher_order, teacher_order: { invoice_flg: @teacher_order.invoice_flg, memo: @teacher_order.memo, memo: @teacher_order.memo, order_date: @teacher_order.order_date, payment_date: @teacher_order.payment_date, payment_flg: @teacher_order.payment_flg, payment_term: @teacher_order.payment_term, teacher_id: @teacher_order.teacher_id, unit_price: @teacher_order.unit_price }
    assert_redirected_to teacher_order_path(assigns(:teacher_order))
  end

  test "should destroy teacher_order" do
    assert_difference('TeacherOrder.count', -1) do
      delete :destroy, id: @teacher_order
    end

    assert_redirected_to teacher_orders_path
  end
end
