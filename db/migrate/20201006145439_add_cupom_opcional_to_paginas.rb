class AddCupomOpcionalToPaginas < ActiveRecord::Migration[5.2]
  def change
    add_column :paginas, :cupom_opcional, :boolean, default: false
  end
end
