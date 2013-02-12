require 'test_helper'

class LvasControllerTest < ActionController::TestCase
  setup do
    @lva = lvas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lvas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lva" do
    assert_difference('Lva.count') do
      post :create, lva: { desc: @lva.desc, ects: @lva.ects, lvanr: @lva.lvanr, name: @lva.name, stunden: @lva.stunden }
    end

    assert_redirected_to lva_path(assigns(:lva))
  end

  test "should show lva" do
    get :show, id: @lva
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lva
    assert_response :success
  end

  test "should update lva" do
    put :update, id: @lva, lva: { desc: @lva.desc, ects: @lva.ects, lvanr: @lva.lvanr, name: @lva.name, stunden: @lva.stunden }
    assert_redirected_to lva_path(assigns(:lva))
  end

  test "should destroy lva" do
    assert_difference('Lva.count', -1) do
      delete :destroy, id: @lva
    end

    assert_redirected_to lvas_path
  end
end
