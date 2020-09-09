class CreateCupons < ActiveRecord::Migration[5.2]
  def change
    create_table :cupons do |t|
      t.string :codigo
      t.datetime :data_inicial
      t.datetime :data_final
      t.boolean :valido

      t.timestamps
    end
  end
end
