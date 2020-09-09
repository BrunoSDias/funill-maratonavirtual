class AddValidoComCupomToPagina < ActiveRecord::Migration[5.2]
  def change
    add_column :paginas, :valido_com_cupom, :boolean, default: false
  end
end
