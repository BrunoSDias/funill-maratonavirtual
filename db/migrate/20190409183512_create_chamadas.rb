class CreateChamadas < ActiveRecord::Migration[5.2]
  def change
    create_table :chamadas do |t|
      t.bigint :chamada_voice_id
      t.datetime :data_criacao
      t.boolean :ativa
      t.string :url_gravacao
      t.bigint :cliente_id
      t.bigint :conta_id
      t.bigint :ramal_id_origem
      t.string :tags
      t.string :status_geral
      t.datetime :origem_data_inicio
      t.string :origem_numero
      t.string :origem_tipo
      t.string :origem_status
      t.integer :origem_duracao_segundos
      t.time :origem_duracao
      t.integer :origem_duracao_cobrada_segundos
      t.time :origem_duracao_cobrada
      t.integer :origem_duracao_falada_segundos
      t.time :origem_duracao_falada
      t.float :origem_preco
      t.string :origem_motivo_desconexao
      t.datetime :destino_data_inicio
      t.string :destino_numero
      t.string :destino_tipo
      t.string :destino_status
      t.integer :destino_duracao_segundos
      t.time :destino_duracao
      t.integer :destino_duracao_cobrada_segundos
      t.time :destino_duracao_cobrada
      t.integer :destino_duracao_falada_segundos
      t.time :destino_duracao_falada
      t.float :destino_preco
      t.string :destino_motivo_desconexao

      t.timestamps
    end
  end
end
