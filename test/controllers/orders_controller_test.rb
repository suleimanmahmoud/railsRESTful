require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { Pacote_id: @order.Pacote_id, compradorname: @order.compradorname, creditocod: @order.creditocod, creditonumber: @order.creditonumber, creditovalidade: @order.creditovalidade, numeropessoas: @order.numeropessoas, numeroquartos: @order.numeroquartos }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { Pacote_id: @order.Pacote_id, compradorname: @order.compradorname, creditocod: @order.creditocod, creditonumber: @order.creditonumber, creditovalidade: @order.creditovalidade, numeropessoas: @order.numeropessoas, numeroquartos: @order.numeroquartos }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end