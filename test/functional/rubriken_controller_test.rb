require 'test_helper'

class RubrikenControllerTest < ActionController::TestCase
  setup do
    @rubrik = rubriken(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rubriken)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rubrik" do
    assert_difference('Rubrik.count') do
      post :create, rubrik: { desc: @rubrik.desc, name: @rubrik.name, prio: @rubrik.prio }
    end

    assert_redirected_to rubrik_path(assigns(:rubrik))
  end

  test "should show rubrik" do
    get :show, id: @rubrik
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rubrik
    assert_response :success
  end

  test "should update rubrik" do
    put :update, id: @rubrik, rubrik: { desc: @rubrik.desc, name: @rubrik.name, prio: @rubrik.prio }
    assert_redirected_to rubrik_path(assigns(:rubrik))
  end

  test "should destroy rubrik" do
    assert_difference('Rubrik.count', -1) do
      delete :destroy, id: @rubrik
    end

    assert_redirected_to rubriken_path
  end
end
