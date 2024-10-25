# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_10_25_024637) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avaliacaos", force: :cascade do |t|
    t.integer "pontos_sono", null: false
    t.integer "pontos_alimentacao", null: false
    t.integer "pontos_imunidade", null: false
    t.float "performance"
    t.integer "total", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "farol_previsto_id"
    t.index ["farol_previsto_id"], name: "index_avaliacaos_on_farol_previsto_id"
    t.index ["usuario_id"], name: "index_avaliacaos_on_usuario_id"
  end

  create_table "evento_alvos", force: :cascade do |t|
    t.datetime "data_evento", null: false
    t.integer "total_semanas", null: false
    t.integer "resultado"
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_evento_alvos_on_usuario_id"
  end

  create_table "evento_testes", force: :cascade do |t|
    t.datetime "data_evento", null: false
    t.integer "resultado", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "farol_previsto_id"
    t.index ["farol_previsto_id"], name: "index_evento_testes_on_farol_previsto_id"
    t.index ["usuario_id"], name: "index_evento_testes_on_usuario_id"
  end

  create_table "farol_desempenhos", force: :cascade do |t|
    t.bigint "farol_id", null: false
    t.bigint "avaliacao_id", null: false
    t.bigint "usuario_id", null: false
    t.string "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avaliacao_id"], name: "index_farol_desempenhos_on_avaliacao_id"
    t.index ["farol_id"], name: "index_farol_desempenhos_on_farol_id"
    t.index ["usuario_id"], name: "index_farol_desempenhos_on_usuario_id"
  end

  create_table "farol_previstos", force: :cascade do |t|
    t.datetime "data_prevista", null: false
    t.integer "semana", null: false
    t.bigint "farol_id", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farol_id"], name: "index_farol_previstos_on_farol_id"
    t.index ["usuario_id"], name: "index_farol_previstos_on_usuario_id"
  end

  create_table "farols", force: :cascade do |t|
    t.string "cor", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cor"], name: "index_farols_on_cor", unique: true
  end

  create_table "finalidades", force: :cascade do |t|
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jogos", force: :cascade do |t|
    t.integer "acertos", null: false
    t.integer "erros", null: false
    t.integer "pontos", null: false
    t.bigint "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_jogos_on_usuario_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "data_nascimento", null: false
    t.string "cpf", null: false
    t.bigint "finalidade_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "daltonismo", default: false
    t.index ["cpf"], name: "index_usuarios_on_cpf", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["finalidade_id"], name: "index_usuarios_on_finalidade_id"
  end

  add_foreign_key "avaliacaos", "farol_previstos"
  add_foreign_key "avaliacaos", "usuarios"
  add_foreign_key "evento_alvos", "usuarios"
  add_foreign_key "evento_testes", "farol_previstos"
  add_foreign_key "evento_testes", "usuarios"
  add_foreign_key "farol_desempenhos", "avaliacaos"
  add_foreign_key "farol_desempenhos", "farols"
  add_foreign_key "farol_desempenhos", "usuarios"
  add_foreign_key "farol_previstos", "farols"
  add_foreign_key "farol_previstos", "usuarios"
  add_foreign_key "jogos", "usuarios"
  add_foreign_key "usuarios", "finalidades"
end
