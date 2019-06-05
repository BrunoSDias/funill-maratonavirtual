class CreateUpsell < ActiveRecord::Migration[5.2]
  def change
    create_table :upsell do |t|
      t.references :produto, foreign_key: true
      t.datetime :data_inicial
      t.datetime :data_final
      t.boolean :somente_boleto
      t.boolean :somente_cartao
      t.integer :tentar_a_cada_compra
      t.integer :mostrar_para_compras_acima_de
      t.float :mostrar_para_compras_ate

      t.timestamps
    end
  end
end
