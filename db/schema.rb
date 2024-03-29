# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_06_145439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administradores", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cupons", force: :cascade do |t|
    t.string "codigo"
    t.datetime "data_inicial"
    t.datetime "data_final"
    t.boolean "valido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_promocoes", force: :cascade do |t|
    t.bigint "promocao_id"
    t.string "codigo_produto"
    t.string "preco_promocional"
    t.integer "quantidade"
    t.string "imagem"
    t.integer "se_pago_vai_para"
    t.string "video"
    t.string "btn_negado"
    t.string "btn_aceito"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["promocao_id"], name: "index_item_promocoes_on_promocao_id"
  end

  create_table "paginas", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.text "conteudo"
    t.bigint "produto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pagina_id"
    t.boolean "inicio"
    t.integer "upsell_id"
    t.boolean "valido_com_cupom", default: false
    t.boolean "cupom_opcional", default: false
    t.index ["produto_id"], name: "index_paginas_on_produto_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "promocoes", force: :cascade do |t|
    t.bigint "upsell_id"
    t.string "nome"
    t.time "tempo_relogio"
    t.integer "se_pago_vai_para"
    t.integer "se_negou_vai_para"
    t.string "titulo"
    t.string "subtitulo"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "conteudo"
    t.index ["upsell_id"], name: "index_promocoes_on_upsell_id"
  end

  create_table "upsell", force: :cascade do |t|
    t.bigint "produto_id"
    t.datetime "data_inicial"
    t.datetime "data_final"
    t.boolean "somente_boleto"
    t.boolean "somente_cartao"
    t.integer "tentar_a_cada_compra"
    t.integer "mostrar_para_compras_acima_de"
    t.float "mostrar_para_compras_ate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome"
    t.index ["produto_id"], name: "index_upsell_on_produto_id"
  end

  add_foreign_key "item_promocoes", "promocoes"
  add_foreign_key "paginas", "produtos"
  add_foreign_key "promocoes", "upsell"
  add_foreign_key "upsell", "produtos"
end
