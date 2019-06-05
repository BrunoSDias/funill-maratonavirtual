class CreatePaginas < ActiveRecord::Migration[5.2]
  def change
    create_table :paginas do |t|
      t.string :nome
      t.string :slug
      t.text :conteudo
      t.references :produto, foreign_key: true

      t.timestamps
    end
  end
end
