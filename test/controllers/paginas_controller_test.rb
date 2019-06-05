require 'test_helper'

class PaginasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pagina = paginas(:one)
  end

  test "should get index" do
    get paginas_url
    assert_response :success
  end

  test "should get new" do
    get new_pagina_url
    assert_response :success
  end

  test "should create pagina" do
    assert_difference('Pagina.count') do
      post paginas_url, params: { pagina: { conteudo: @pagina.conteudo, nome: @pagina.nome, produto_id: @pagina.produto_id, slug: @pagina.slug } }
    end

    assert_redirected_to pagina_url(Pagina.last)
  end

  test "should show pagina" do
    get pagina_url(@pagina)
    assert_response :success
  end

  test "should get edit" do
    get edit_pagina_url(@pagina)
    assert_response :success
  end

  test "should update pagina" do
    patch pagina_url(@pagina), params: { pagina: { conteudo: @pagina.conteudo, nome: @pagina.nome, produto_id: @pagina.produto_id, slug: @pagina.slug } }
    assert_redirected_to pagina_url(@pagina)
  end

  test "should destroy pagina" do
    assert_difference('Pagina.count', -1) do
      delete pagina_url(@pagina)
    end

    assert_redirected_to paginas_url
  end
end
