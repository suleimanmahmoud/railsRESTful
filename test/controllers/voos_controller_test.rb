require 'test_helper'

class VoosControllerTest < ActionController::TestCase
  setup do
    @voo = voos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:voos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create voo" do
    assert_difference('Voo.count') do
      post :create, voo: { dataida: @voo.dataida, datavolta: @voo.datavolta, destino: @voo.destino, name: @voo.name, origem: @voo.origem, price: @voo.price, tipo: @voo.tipo }
    end

    assert_redirected_to voo_path(assigns(:voo))
  end

  test "should show voo" do
    get :show, id: @voo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @voo
    assert_response :success
  end

  test "should update voo" do
    patch :update, id: @voo, voo: { dataida: @voo.dataida, datavolta: @voo.datavolta, destino: @voo.destino, name: @voo.name, origem: @voo.origem, price: @voo.price, tipo: @voo.tipo }
    assert_redirected_to voo_path(assigns(:voo))
  end

  test "should destroy voo" do
    assert_difference('Voo.count', -1) do
      delete :destroy, id: @voo
    end

    assert_redirected_to voos_path
  end
end
