class ProximaPagina < ActiveRecord::Migration[5.2]
  def change
  	add_column :paginas, :pagina_id, :integer
  end
end
