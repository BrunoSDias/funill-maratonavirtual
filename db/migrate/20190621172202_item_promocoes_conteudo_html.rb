class ItemPromocoesConteudoHtml < ActiveRecord::Migration[5.2]
  def change
  	add_column :promocoes, :conteudo, :text
  end
end
