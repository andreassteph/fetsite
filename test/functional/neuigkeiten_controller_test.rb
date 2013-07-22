require 'test_helper'

class NeuigkeitenControllerTest < ActionController::TestCase
  setup do
    @neuigkeit = neuigkeiten(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:neuigkeiten)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create neuigkeit" do
    assert_difference('Neuigkeit.count') do
      post :create, neuigkeit: { datum: @neuigkeit.datum, text: @neuigkeit.text, title: @neuigkeit.title }
    end

    assert_redirected_to neuigkeit_path(assigns(:neuigkeit))
  end

  test "should show neuigkeit" do
    get :show, id: @neuigkeit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @neuigkeit
    assert_response :success
  end

  test "should update neuigkeit" do
    put :update, id: @neuigkeit, neuigkeit: { datum: @neuigkeit.datum, text: @neuigkeit.text, title: @neuigkeit.title }
    assert_redirected_to neuigkeit_path(assigns(:neuigkeit))
  end

  test "should destroy neuigkeit" do
    assert_difference('Neuigkeit.count', -1) do
      delete :destroy, id: @neuigkeit
    end

    assert_redirected_to neuigkeiten_path
  end
end
