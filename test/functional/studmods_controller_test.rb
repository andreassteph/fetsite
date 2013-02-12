require 'test_helper'

class StudmodsControllerTest < ActionController::TestCase
  setup do
    @studmod = studmods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studmods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create studmod" do
    assert_difference('Studmod.count') do
      post :create, studmod: { modul_id: @studmod.modul_id, studium_id: @studmod.studium_id }
    end

    assert_redirected_to studmod_path(assigns(:studmod))
  end

  test "should show studmod" do
    get :show, id: @studmod
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @studmod
    assert_response :success
  end

  test "should update studmod" do
    put :update, id: @studmod, studmod: { modul_id: @studmod.modul_id, studium_id: @studmod.studium_id }
    assert_redirected_to studmod_path(assigns(:studmod))
  end

  test "should destroy studmod" do
    assert_difference('Studmod.count', -1) do
      delete :destroy, id: @studmod
    end

    assert_redirected_to studmods_path
  end
end
