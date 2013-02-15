require 'test_helper'

class BeispieleControllerTest < ActionController::TestCase
  setup do
    @beispiel = beispiele(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beispiele)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create beispiel" do
    assert_difference('Beispiel.count') do
      post :create, beispiel: { desc: @beispiel.desc, name: @beispiel.name }
    end

    assert_redirected_to beispiel_path(assigns(:beispiel))
  end

  test "should show beispiel" do
    get :show, id: @beispiel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @beispiel
    assert_response :success
  end

  test "should update beispiel" do
    put :update, id: @beispiel, beispiel: { desc: @beispiel.desc, name: @beispiel.name }
    assert_redirected_to beispiel_path(assigns(:beispiel))
  end

  test "should destroy beispiel" do
    assert_difference('Beispiel.count', -1) do
      delete :destroy, id: @beispiel
    end

    assert_redirected_to beispiele_path
  end
end
