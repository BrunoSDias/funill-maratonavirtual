require "application_system_test_case"

class PaginasTest < ApplicationSystemTestCase
  setup do
    @pagina = paginas(:one)
  end

  test "visiting the index" do
    visit paginas_url
    assert_selector "h1", text: "Paginas"
  end

  test "creating a Pagina" do
    visit paginas_url
    click_on "New Pagina"

    fill_in "Conteudo", with: @pagina.conteudo
    fill_in "Nome", with: @pagina.nome
    fill_in "Produto", with: @pagina.produto_id
    fill_in "Slug", with: @pagina.slug
    click_on "Create Pagina"

    assert_text "Pagina was successfully created"
    click_on "Back"
  end

  test "updating a Pagina" do
    visit paginas_url
    click_on "Edit", match: :first

    fill_in "Conteudo", with: @pagina.conteudo
    fill_in "Nome", with: @pagina.nome
    fill_in "Produto", with: @pagina.produto_id
    fill_in "Slug", with: @pagina.slug
    click_on "Update Pagina"

    assert_text "Pagina was successfully updated"
    click_on "Back"
  end

  test "destroying a Pagina" do
    visit paginas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pagina was successfully destroyed"
  end
end
