class PaginaUpsell < ActiveRecord::Migration[5.2]
  def change
  	add_column :paginas, :upsell_id, :integer
  	add_column :upsell, :nome, :string
  end
end
