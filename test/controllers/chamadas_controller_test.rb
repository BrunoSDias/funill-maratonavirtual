require 'test_helper'

class ChamadasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chamada = chamadas(:one)
  end

  test "should get index" do
    get chamadas_url
    assert_response :success
  end

  test "should get new" do
    get new_chamada_url
    assert_response :success
  end

  test "should create chamada" do
    assert_difference('Chamada.count') do
      post chamadas_url, params: { chamada: { ativa: @chamada.ativa, chamada_voice_id: @chamada.chamada_voice_id, cliente_id: @chamada.cliente_id, conta_id: @chamada.conta_id, data_criacao: @chamada.data_criacao, destino_data_inicio: @chamada.destino_data_inicio, destino_duracao: @chamada.destino_duracao, destino_duracao_cobrada: @chamada.destino_duracao_cobrada, destino_duracao_cobrada_segundos: @chamada.destino_duracao_cobrada_segundos, destino_duracao_falada: @chamada.destino_duracao_falada, destino_duracao_falada_segundos: @chamada.destino_duracao_falada_segundos, destino_duracao_segundos: @chamada.destino_duracao_segundos, destino_motivo_desconexao: @chamada.destino_motivo_desconexao, destino_numero: @chamada.destino_numero, destino_preco: @chamada.destino_preco, destino_status: @chamada.destino_status, destino_tipo: @chamada.destino_tipo, origem_data_inicio: @chamada.origem_data_inicio, origem_duracao: @chamada.origem_duracao, origem_duracao_cobrada: @chamada.origem_duracao_cobrada, origem_duracao_cobrada_segundos: @chamada.origem_duracao_cobrada_segundos, origem_duracao_falada: @chamada.origem_duracao_falada, origem_duracao_falada_segundos: @chamada.origem_duracao_falada_segundos, origem_duracao_segundos: @chamada.origem_duracao_segundos, origem_motivo_desconexao: @chamada.origem_motivo_desconexao, origem_numero: @chamada.origem_numero, origem_preco: @chamada.origem_preco, origem_status: @chamada.origem_status, origem_tipo: @chamada.origem_tipo, ramal_id_origem: @chamada.ramal_id_origem, status_geral: @chamada.status_geral, tags: @chamada.tags, url_gravacao: @chamada.url_gravacao } }
    end

    assert_redirected_to chamada_url(Chamada.last)
  end

  test "should show chamada" do
    get chamada_url(@chamada)
    assert_response :success
  end

  test "should get edit" do
    get edit_chamada_url(@chamada)
    assert_response :success
  end

  test "should update chamada" do
    patch chamada_url(@chamada), params: { chamada: { ativa: @chamada.ativa, chamada_voice_id: @chamada.chamada_voice_id, cliente_id: @chamada.cliente_id, conta_id: @chamada.conta_id, data_criacao: @chamada.data_criacao, destino_data_inicio: @chamada.destino_data_inicio, destino_duracao: @chamada.destino_duracao, destino_duracao_cobrada: @chamada.destino_duracao_cobrada, destino_duracao_cobrada_segundos: @chamada.destino_duracao_cobrada_segundos, destino_duracao_falada: @chamada.destino_duracao_falada, destino_duracao_falada_segundos: @chamada.destino_duracao_falada_segundos, destino_duracao_segundos: @chamada.destino_duracao_segundos, destino_motivo_desconexao: @chamada.destino_motivo_desconexao, destino_numero: @chamada.destino_numero, destino_preco: @chamada.destino_preco, destino_status: @chamada.destino_status, destino_tipo: @chamada.destino_tipo, origem_data_inicio: @chamada.origem_data_inicio, origem_duracao: @chamada.origem_duracao, origem_duracao_cobrada: @chamada.origem_duracao_cobrada, origem_duracao_cobrada_segundos: @chamada.origem_duracao_cobrada_segundos, origem_duracao_falada: @chamada.origem_duracao_falada, origem_duracao_falada_segundos: @chamada.origem_duracao_falada_segundos, origem_duracao_segundos: @chamada.origem_duracao_segundos, origem_motivo_desconexao: @chamada.origem_motivo_desconexao, origem_numero: @chamada.origem_numero, origem_preco: @chamada.origem_preco, origem_status: @chamada.origem_status, origem_tipo: @chamada.origem_tipo, ramal_id_origem: @chamada.ramal_id_origem, status_geral: @chamada.status_geral, tags: @chamada.tags, url_gravacao: @chamada.url_gravacao } }
    assert_redirected_to chamada_url(@chamada)
  end

  test "should destroy chamada" do
    assert_difference('Chamada.count', -1) do
      delete chamada_url(@chamada)
    end

    assert_redirected_to chamadas_url
  end
end
