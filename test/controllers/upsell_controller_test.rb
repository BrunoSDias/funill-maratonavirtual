require 'test_helper'

class UpsellControllerTest < ActionDispatch::IntegrationTest
  setup do
    @upsell = upsell(:one)
  end

  test "should get index" do
    get upsell_index_url
    assert_response :success
  end

  test "should get new" do
    get new_upsell_url
    assert_response :success
  end

  test "should create upsell" do
    assert_difference('Upsell.count') do
      post upsell_index_url, params: { upsell: { data_final: @upsell.data_final, data_inicial: @upsell.data_inicial, mostrar_para_compras_acima_de: @upsell.mostrar_para_compras_acima_de, mostrar_para_compras_ate: @upsell.mostrar_para_compras_ate, produto_id: @upsell.produto_id, somente_boleto: @upsell.somente_boleto, somente_cartao: @upsell.somente_cartao, tentar_a_cada_compra: @upsell.tentar_a_cada_compra } }
    end

    assert_redirected_to upsell_url(Upsell.last)
  end

  test "should show upsell" do
    get upsell_url(@upsell)
    assert_response :success
  end

  test "should get edit" do
    get edit_upsell_url(@upsell)
    assert_response :success
  end

  test "should update upsell" do
    patch upsell_url(@upsell), params: { upsell: { data_final: @upsell.data_final, data_inicial: @upsell.data_inicial, mostrar_para_compras_acima_de: @upsell.mostrar_para_compras_acima_de, mostrar_para_compras_ate: @upsell.mostrar_para_compras_ate, produto_id: @upsell.produto_id, somente_boleto: @upsell.somente_boleto, somente_cartao: @upsell.somente_cartao, tentar_a_cada_compra: @upsell.tentar_a_cada_compra } }
    assert_redirected_to upsell_url(@upsell)
  end

  test "should destroy upsell" do
    assert_difference('Upsell.count', -1) do
      delete upsell_url(@upsell)
    end

    assert_redirected_to upsell_index_url
  end
end
