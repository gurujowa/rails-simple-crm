require 'test_helper'

class PublicBillsControllerTest < ActionController::TestCase
  setup do
    @public_bill = public_bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:public_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create public_bill" do
    assert_difference('PublicBill.count') do
      post :create, public_bill: { company_name: @public_bill.company_name, invoice_date: @public_bill.invoice_date, memo: @public_bill.memo, name: @public_bill.name, payment_date: @public_bill.payment_date, publish_date: @public_bill.publish_date, send_flg: @public_bill.send_flg }
    end

    assert_redirected_to public_bill_path(assigns(:public_bill))
  end

  test "should show public_bill" do
    get :show, id: @public_bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @public_bill
    assert_response :success
  end

  test "should update public_bill" do
    patch :update, id: @public_bill, public_bill: { company_name: @public_bill.company_name, invoice_date: @public_bill.invoice_date, memo: @public_bill.memo, name: @public_bill.name, payment_date: @public_bill.payment_date, publish_date: @public_bill.publish_date, send_flg: @public_bill.send_flg }
    assert_redirected_to public_bill_path(assigns(:public_bill))
  end

  test "should destroy public_bill" do
    assert_difference('PublicBill.count', -1) do
      delete :destroy, id: @public_bill
    end

    assert_redirected_to public_bills_path
  end
end
