require 'test_helper'

class TeachersControllerTest < ActionController::TestCase
  setup do
    @teacher = teachers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teachers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher" do
    assert_difference('Teacher.count') do
      post :create, teacher: { first_kana: @teacher.first_kana, first_kanji: @teacher.first_kanji, genre: @teacher.genre, last_kana: @teacher.last_kana, last_kanji: @teacher.last_kanji, memo: @teacher.memo, work_possible: @teacher.work_possible }
    end

    assert_redirected_to teacher_path(assigns(:teacher))
  end

  test "should show teacher" do
    get :show, id: @teacher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher
    assert_response :success
  end

  test "should update teacher" do
    patch :update, id: @teacher, teacher: { first_kana: @teacher.first_kana, first_kanji: @teacher.first_kanji, genre: @teacher.genre, last_kana: @teacher.last_kana, last_kanji: @teacher.last_kanji, memo: @teacher.memo, work_possible: @teacher.work_possible }
    assert_redirected_to teacher_path(assigns(:teacher))
  end

  test "should destroy teacher" do
    assert_difference('Teacher.count', -1) do
      delete :destroy, id: @teacher
    end

    assert_redirected_to teachers_path
  end
end
