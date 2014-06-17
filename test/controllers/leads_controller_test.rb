require 'test_helper'

class LeadsControllerTest < ActionController::TestCase
  setup do
    @lead = leads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lead" do
    assert_difference('Lead.count') do
      post :create, lead: { building: @lead.building, email: @lead.email, fax: @lead.fax, memo: @lead.memo, name: @lead.name, person_kana: @lead.person_kana, person_name: @lead.person_name, person_post: @lead.person_post, prefecture: @lead.prefecture, star: @lead.star, street: @lead.street, tel: @lead.tel, url: @lead.url, user_id: @lead.user_id, zip_code: @lead.zip_code }
    end

    assert_redirected_to lead_path(assigns(:lead))
  end

  test "should show lead" do
    get :show, id: @lead
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lead
    assert_response :success
  end

  test "should update lead" do
    patch :update, id: @lead, lead: { building: @lead.building, email: @lead.email, fax: @lead.fax, memo: @lead.memo, name: @lead.name, person_kana: @lead.person_kana, person_name: @lead.person_name, person_post: @lead.person_post, prefecture: @lead.prefecture, star: @lead.star, street: @lead.street, tel: @lead.tel, url: @lead.url, user_id: @lead.user_id, zip_code: @lead.zip_code }
    assert_redirected_to lead_path(assigns(:lead))
  end

  test "should destroy lead" do
    assert_difference('Lead.count', -1) do
      delete :destroy, id: @lead
    end

    assert_redirected_to leads_path
  end
end
