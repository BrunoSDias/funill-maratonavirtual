class SlugProduto < ActiveRecord::Migration[5.2]
  def change
  	add_column :produtos, :slug, :string
  end
end
