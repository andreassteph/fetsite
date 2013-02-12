require 'test_helper'

class StudiaControllerTest < ActionController::TestCase
  setup do
    @studium = studia(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studia)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create studium" do
    assert_difference('Studium.count') do
      post :create, studium: { desc: @studium.desc, name: @studium.name, typ: @studium.typ, zahl: @studium.zahl }
    end

    assert_redirected_to studium_path(assigns(:studium))
  end

  test "should show studium" do
    get :show, id: @studium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @studium
    assert_response :success
  end

  test "should update studium" do
    put :update, id: @studium, studium: { desc: @studium.desc, name: @studium.name, typ: @studium.typ, zahl: @studium.zahl }
    assert_redirected_to studium_path(assigns(:studium))
  end

  test "should destroy studium" do
    assert_difference('Studium.count', -1) do
      delete :destroy, id: @studium
    end

    assert_redirected_to studia_path
  end
end
