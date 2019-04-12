class CamposChamada < ActiveRecord::Migration[5.2]
  def change
  	add_column :chamadas, :origem_duracao_string, :string
  	add_column :chamadas, :origem_duracao_cobrada_string, :string
  	add_column :chamadas, :origem_duracao_falada_string, :string

  	add_column :chamadas, :destino_duracao_string, :string
  	add_column :chamadas, :destino_duracao_cobrada_string, :string
  	add_column :chamadas, :destino_duracao_falada_string, :string

  	add_column :chamadas, :login, :string
  end
end
