class CreatePromocoes < ActiveRecord::Migration[5.2]
  def change
    create_table :promocoes do |t|
      t.references :upsell, foreign_key: true
      t.string :nome
      t.time :tempo_relogio
      t.integer :se_pago_vai_para
      t.integer :se_negou_vai_para
      t.string :titulo
      t.string :subtitulo
      t.string :descricao

      t.timestamps
    end
  end
end
