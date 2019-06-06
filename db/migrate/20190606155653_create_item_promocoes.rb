class CreateItemPromocoes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_promocoes do |t|
      t.references :promocao, foreign_key: true
      t.string :codigo_produto
      t.string :preco_promocional
      t.integer :quantidade
      t.string :imagem
      t.integer :se_pago_vai_para
      t.string :video
      t.string :btn_negado
      t.string :btn_aceito

      t.timestamps
    end
  end
end
