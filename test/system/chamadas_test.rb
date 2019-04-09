require "application_system_test_case"

class ChamadasTest < ApplicationSystemTestCase
  setup do
    @chamada = chamadas(:one)
  end

  test "visiting the index" do
    visit chamadas_url
    assert_selector "h1", text: "Chamadas"
  end

  test "creating a Chamada" do
    visit chamadas_url
    click_on "New Chamada"

    check "Ativa" if @chamada.ativa
    fill_in "Chamada voice", with: @chamada.chamada_voice_id
    fill_in "Cliente", with: @chamada.cliente_id
    fill_in "Conta", with: @chamada.conta_id
    fill_in "Data criacao", with: @chamada.data_criacao
    fill_in "Destino data inicio", with: @chamada.destino_data_inicio
    fill_in "Destino duracao", with: @chamada.destino_duracao
    fill_in "Destino duracao cobrada", with: @chamada.destino_duracao_cobrada
    fill_in "Destino duracao cobrada segundos", with: @chamada.destino_duracao_cobrada_segundos
    fill_in "Destino duracao falada", with: @chamada.destino_duracao_falada
    fill_in "Destino duracao falada segundos", with: @chamada.destino_duracao_falada_segundos
    fill_in "Destino duracao segundos", with: @chamada.destino_duracao_segundos
    fill_in "Destino motivo desconexao", with: @chamada.destino_motivo_desconexao
    fill_in "Destino numero", with: @chamada.destino_numero
    fill_in "Destino preco", with: @chamada.destino_preco
    fill_in "Destino status", with: @chamada.destino_status
    fill_in "Destino tipo", with: @chamada.destino_tipo
    fill_in "Origem data inicio", with: @chamada.origem_data_inicio
    fill_in "Origem duracao", with: @chamada.origem_duracao
    fill_in "Origem duracao cobrada", with: @chamada.origem_duracao_cobrada
    fill_in "Origem duracao cobrada segundos", with: @chamada.origem_duracao_cobrada_segundos
    fill_in "Origem duracao falada", with: @chamada.origem_duracao_falada
    fill_in "Origem duracao falada segundos", with: @chamada.origem_duracao_falada_segundos
    fill_in "Origem duracao segundos", with: @chamada.origem_duracao_segundos
    fill_in "Origem motivo desconexao", with: @chamada.origem_motivo_desconexao
    fill_in "Origem numero", with: @chamada.origem_numero
    fill_in "Origem preco", with: @chamada.origem_preco
    fill_in "Origem status", with: @chamada.origem_status
    fill_in "Origem tipo", with: @chamada.origem_tipo
    fill_in "Ramal id origem", with: @chamada.ramal_id_origem
    fill_in "Status geral", with: @chamada.status_geral
    fill_in "Tags", with: @chamada.tags
    fill_in "Url gravacao", with: @chamada.url_gravacao
    click_on "Create Chamada"

    assert_text "Chamada was successfully created"
    click_on "Back"
  end

  test "updating a Chamada" do
    visit chamadas_url
    click_on "Edit", match: :first

    check "Ativa" if @chamada.ativa
    fill_in "Chamada voice", with: @chamada.chamada_voice_id
    fill_in "Cliente", with: @chamada.cliente_id
    fill_in "Conta", with: @chamada.conta_id
    fill_in "Data criacao", with: @chamada.data_criacao
    fill_in "Destino data inicio", with: @chamada.destino_data_inicio
    fill_in "Destino duracao", with: @chamada.destino_duracao
    fill_in "Destino duracao cobrada", with: @chamada.destino_duracao_cobrada
    fill_in "Destino duracao cobrada segundos", with: @chamada.destino_duracao_cobrada_segundos
    fill_in "Destino duracao falada", with: @chamada.destino_duracao_falada
    fill_in "Destino duracao falada segundos", with: @chamada.destino_duracao_falada_segundos
    fill_in "Destino duracao segundos", with: @chamada.destino_duracao_segundos
    fill_in "Destino motivo desconexao", with: @chamada.destino_motivo_desconexao
    fill_in "Destino numero", with: @chamada.destino_numero
    fill_in "Destino preco", with: @chamada.destino_preco
    fill_in "Destino status", with: @chamada.destino_status
    fill_in "Destino tipo", with: @chamada.destino_tipo
    fill_in "Origem data inicio", with: @chamada.origem_data_inicio
    fill_in "Origem duracao", with: @chamada.origem_duracao
    fill_in "Origem duracao cobrada", with: @chamada.origem_duracao_cobrada
    fill_in "Origem duracao cobrada segundos", with: @chamada.origem_duracao_cobrada_segundos
    fill_in "Origem duracao falada", with: @chamada.origem_duracao_falada
    fill_in "Origem duracao falada segundos", with: @chamada.origem_duracao_falada_segundos
    fill_in "Origem duracao segundos", with: @chamada.origem_duracao_segundos
    fill_in "Origem motivo desconexao", with: @chamada.origem_motivo_desconexao
    fill_in "Origem numero", with: @chamada.origem_numero
    fill_in "Origem preco", with: @chamada.origem_preco
    fill_in "Origem status", with: @chamada.origem_status
    fill_in "Origem tipo", with: @chamada.origem_tipo
    fill_in "Ramal id origem", with: @chamada.ramal_id_origem
    fill_in "Status geral", with: @chamada.status_geral
    fill_in "Tags", with: @chamada.tags
    fill_in "Url gravacao", with: @chamada.url_gravacao
    click_on "Update Chamada"

    assert_text "Chamada was successfully updated"
    click_on "Back"
  end

  test "destroying a Chamada" do
    visit chamadas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Chamada was successfully destroyed"
  end
end
