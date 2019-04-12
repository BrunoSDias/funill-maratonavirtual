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

ActiveRecord::Schema.define(version: 2019_04_12_192535) do

  create_table "administradores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chamadas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "chamada_voice_id"
    t.datetime "data_criacao"
    t.boolean "ativa"
    t.string "url_gravacao"
    t.bigint "cliente_id"
    t.bigint "conta_id"
    t.bigint "ramal_id_origem"
    t.string "tags"
    t.string "status_geral"
    t.datetime "origem_data_inicio"
    t.string "origem_numero"
    t.string "origem_tipo"
    t.string "origem_status"
    t.integer "origem_duracao_segundos"
    t.time "origem_duracao"
    t.integer "origem_duracao_cobrada_segundos"
    t.time "origem_duracao_cobrada"
    t.integer "origem_duracao_falada_segundos"
    t.time "origem_duracao_falada"
    t.float "origem_preco"
    t.string "origem_motivo_desconexao"
    t.datetime "destino_data_inicio"
    t.string "destino_numero"
    t.string "destino_tipo"
    t.string "destino_status"
    t.integer "destino_duracao_segundos"
    t.time "destino_duracao"
    t.integer "destino_duracao_cobrada_segundos"
    t.time "destino_duracao_cobrada"
    t.integer "destino_duracao_falada_segundos"
    t.time "destino_duracao_falada"
    t.float "destino_preco"
    t.string "destino_motivo_desconexao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origem_duracao_string"
    t.string "origem_duracao_cobrada_string"
    t.string "origem_duracao_falada_string"
    t.string "destino_duracao_string"
    t.string "destino_duracao_cobrada_string"
    t.string "destino_duracao_falada_string"
    t.string "login"
  end

end
