require "application_system_test_case"

class UpsellTest < ApplicationSystemTestCase
  setup do
    @upsell = upsell(:one)
  end

  test "visiting the index" do
    visit upsell_url
    assert_selector "h1", text: "Upsell"
  end

  test "creating a Upsell" do
    visit upsell_url
    click_on "New Upsell"

    fill_in "Data final", with: @upsell.data_final
    fill_in "Data inicial", with: @upsell.data_inicial
    fill_in "Mostrar para compras acima de", with: @upsell.mostrar_para_compras_acima_de
    fill_in "Mostrar para compras ate", with: @upsell.mostrar_para_compras_ate
    fill_in "Produto", with: @upsell.produto_id
    check "Somente boleto" if @upsell.somente_boleto
    check "Somente cartao" if @upsell.somente_cartao
    fill_in "Tentar a cada compra", with: @upsell.tentar_a_cada_compra
    click_on "Create Upsell"

    assert_text "Upsell was successfully created"
    click_on "Back"
  end

  test "updating a Upsell" do
    visit upsell_url
    click_on "Edit", match: :first

    fill_in "Data final", with: @upsell.data_final
    fill_in "Data inicial", with: @upsell.data_inicial
    fill_in "Mostrar para compras acima de", with: @upsell.mostrar_para_compras_acima_de
    fill_in "Mostrar para compras ate", with: @upsell.mostrar_para_compras_ate
    fill_in "Produto", with: @upsell.produto_id
    check "Somente boleto" if @upsell.somente_boleto
    check "Somente cartao" if @upsell.somente_cartao
    fill_in "Tentar a cada compra", with: @upsell.tentar_a_cada_compra
    click_on "Update Upsell"

    assert_text "Upsell was successfully updated"
    click_on "Back"
  end

  test "destroying a Upsell" do
    visit upsell_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Upsell was successfully destroyed"
  end
end
