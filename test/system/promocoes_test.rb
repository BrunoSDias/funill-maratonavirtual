require "application_system_test_case"

class PromocoesTest < ApplicationSystemTestCase
  setup do
    @promocao = promocoes(:one)
  end

  test "visiting the index" do
    visit promocoes_url
    assert_selector "h1", text: "Promocoes"
  end

  test "creating a Promocao" do
    visit promocoes_url
    click_on "New Promocao"

    fill_in "Descricao", with: @promocao.descricao
    fill_in "Nome", with: @promocao.nome
    fill_in "Se negou vai para", with: @promocao.se_negou_vai_para
    fill_in "Se pago vai para", with: @promocao.se_pago_vai_para
    fill_in "Subtitulo", with: @promocao.subtitulo
    fill_in "Tempo relogio", with: @promocao.tempo_relogio
    fill_in "Titulo", with: @promocao.titulo
    fill_in "Upsell", with: @promocao.upsell_id
    click_on "Create Promocao"

    assert_text "Promocao was successfully created"
    click_on "Back"
  end

  test "updating a Promocao" do
    visit promocoes_url
    click_on "Edit", match: :first

    fill_in "Descricao", with: @promocao.descricao
    fill_in "Nome", with: @promocao.nome
    fill_in "Se negou vai para", with: @promocao.se_negou_vai_para
    fill_in "Se pago vai para", with: @promocao.se_pago_vai_para
    fill_in "Subtitulo", with: @promocao.subtitulo
    fill_in "Tempo relogio", with: @promocao.tempo_relogio
    fill_in "Titulo", with: @promocao.titulo
    fill_in "Upsell", with: @promocao.upsell_id
    click_on "Update Promocao"

    assert_text "Promocao was successfully updated"
    click_on "Back"
  end

  test "destroying a Promocao" do
    visit promocoes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Promocao was successfully destroyed"
  end
end
