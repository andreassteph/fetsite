require 'test_helper'

class ModulgruppenControllerTest < ActionController::TestCase
  setup do
    @modulgruppe = modulgruppen(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:modulgruppen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create modulgruppe" do
    assert_difference('Modulgruppe.count') do
      post :create, modulgruppe: { name: @modulgruppe.name, phase: @modulgruppe.phase, studium_id: @modulgruppe.studium_id, type: @modulgruppe.type }
    end

    assert_redirected_to modulgruppe_path(assigns(:modulgruppe))
  end

  test "should show modulgruppe" do
    get :show, id: @modulgruppe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @modulgruppe
    assert_response :success
  end

  test "should update modulgruppe" do
    put :update, id: @modulgruppe, modulgruppe: { name: @modulgruppe.name, phase: @modulgruppe.phase, studium_id: @modulgruppe.studium_id, type: @modulgruppe.type }
    assert_redirected_to modulgruppe_path(assigns(:modulgruppe))
  end

  test "should destroy modulgruppe" do
    assert_difference('Modulgruppe.count', -1) do
      delete :destroy, id: @modulgruppe
    end

    assert_redirected_to modulgruppen_path
  end
end
