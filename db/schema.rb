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

ActiveRecord::Schema.define(version: 2019_06_05_172709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administradores", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paginas", force: :cascade do |t|
    t.string "nome"
    t.string "slug"
    t.text "conteudo"
    t.bigint "produto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pagina_id"
    t.index ["produto_id"], name: "index_paginas_on_produto_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["produto_id"], name: "index_upsell_on_produto_id"
  end

  add_foreign_key "paginas", "produtos"
  add_foreign_key "upsell", "produtos"
end
