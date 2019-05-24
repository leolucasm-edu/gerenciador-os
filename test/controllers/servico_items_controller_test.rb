require 'test_helper'

class ServicoItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @servico_item = servico_items(:one)
  end

  test "should get index" do
    get servico_items_url
    assert_response :success
  end

  test "should get new" do
    get new_servico_item_url
    assert_response :success
  end

  test "should create servico_item" do
    assert_difference('ServicoItem.count') do
      post servico_items_url, params: { servico_item: { ordem_servico_id: @servico_item.ordem_servico_id, preco_hora: @servico_item.preco_hora, quantidade_horas: @servico_item.quantidade_horas, servico_id: @servico_item.servico_id } }
    end

    assert_redirected_to servico_item_url(ServicoItem.last)
  end

  test "should show servico_item" do
    get servico_item_url(@servico_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_servico_item_url(@servico_item)
    assert_response :success
  end

  test "should update servico_item" do
    patch servico_item_url(@servico_item), params: { servico_item: { ordem_servico_id: @servico_item.ordem_servico_id, preco_hora: @servico_item.preco_hora, quantidade_horas: @servico_item.quantidade_horas, servico_id: @servico_item.servico_id } }
    assert_redirected_to servico_item_url(@servico_item)
  end

  test "should destroy servico_item" do
    assert_difference('ServicoItem.count', -1) do
      delete servico_item_url(@servico_item)
    end

    assert_redirected_to servico_items_url
  end
end
