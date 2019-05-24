require 'test_helper'

class ProdutoItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @produto_item = produto_items(:one)
  end

  test "should get index" do
    get produto_items_url
    assert_response :success
  end

  test "should get new" do
    get new_produto_item_url
    assert_response :success
  end

  test "should create produto_item" do
    assert_difference('ProdutoItem.count') do
      post produto_items_url, params: { produto_item: { ordem_servico_id: @produto_item.ordem_servico_id, preco_unitario: @produto_item.preco_unitario, produto_id: @produto_item.produto_id, quantidade: @produto_item.quantidade } }
    end

    assert_redirected_to produto_item_url(ProdutoItem.last)
  end

  test "should show produto_item" do
    get produto_item_url(@produto_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_produto_item_url(@produto_item)
    assert_response :success
  end

  test "should update produto_item" do
    patch produto_item_url(@produto_item), params: { produto_item: { ordem_servico_id: @produto_item.ordem_servico_id, preco_unitario: @produto_item.preco_unitario, produto_id: @produto_item.produto_id, quantidade: @produto_item.quantidade } }
    assert_redirected_to produto_item_url(@produto_item)
  end

  test "should destroy produto_item" do
    assert_difference('ProdutoItem.count', -1) do
      delete produto_item_url(@produto_item)
    end

    assert_redirected_to produto_items_url
  end
end
