require 'test_helper'

class PromocoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promocao = promocoes(:one)
  end

  test "should get index" do
    get promocoes_url
    assert_response :success
  end

  test "should get new" do
    get new_promocao_url
    assert_response :success
  end

  test "should create promocao" do
    assert_difference('Promocao.count') do
      post promocoes_url, params: { promocao: { descricao: @promocao.descricao, nome: @promocao.nome, se_negou_vai_para: @promocao.se_negou_vai_para, se_pago_vai_para: @promocao.se_pago_vai_para, subtitulo: @promocao.subtitulo, tempo_relogio: @promocao.tempo_relogio, titulo: @promocao.titulo, upsell_id: @promocao.upsell_id } }
    end

    assert_redirected_to promocao_url(Promocao.last)
  end

  test "should show promocao" do
    get promocao_url(@promocao)
    assert_response :success
  end

  test "should get edit" do
    get edit_promocao_url(@promocao)
    assert_response :success
  end

  test "should update promocao" do
    patch promocao_url(@promocao), params: { promocao: { descricao: @promocao.descricao, nome: @promocao.nome, se_negou_vai_para: @promocao.se_negou_vai_para, se_pago_vai_para: @promocao.se_pago_vai_para, subtitulo: @promocao.subtitulo, tempo_relogio: @promocao.tempo_relogio, titulo: @promocao.titulo, upsell_id: @promocao.upsell_id } }
    assert_redirected_to promocao_url(@promocao)
  end

  test "should destroy promocao" do
    assert_difference('Promocao.count', -1) do
      delete promocao_url(@promocao)
    end

    assert_redirected_to promocoes_url
  end
end
