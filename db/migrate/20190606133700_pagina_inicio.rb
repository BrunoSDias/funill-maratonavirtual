class PaginaInicio < ActiveRecord::Migration[5.2]
  def change
  	add_column :paginas, :inicio, :boolean
  end
end
