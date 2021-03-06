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

ActiveRecord::Schema.define(version: 20190524030645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "clientes", force: :cascade do |t|
    t.text "nome"
    t.text "cpf_cnpj"
    t.date "data_nascimento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telefone"
  end

  create_table "emails", force: :cascade do |t|
    t.string "email"
    t.bigint "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_emails_on_cliente_id"
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "rua"
    t.string "cidade"
    t.string "estado"
    t.string "cep"
    t.string "numero"
    t.string "bairro"
    t.string "complemento"
    t.bigint "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_enderecos_on_cliente_id"
  end

  create_table "funcionarios", force: :cascade do |t|
    t.string "nome"
    t.string "cnpj"
    t.string "email"
    t.string "data_nascimento"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "telefone"
  end

  create_table "ordem_servicos", force: :cascade do |t|
    t.bigint "cliente_id"
    t.text "problema"
    t.string "equipamento"
    t.bigint "funcionario_id"
    t.string "data_abertura"
    t.string "data_encerramento"
    t.string "data_previsao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_total", default: "0.0"
    t.index ["cliente_id"], name: "index_ordem_servicos_on_cliente_id"
    t.index ["funcionario_id"], name: "index_ordem_servicos_on_funcionario_id"
  end

  create_table "produto_items", force: :cascade do |t|
    t.bigint "produto_id"
    t.bigint "ordem_servico_id"
    t.decimal "quantidade"
    t.decimal "preco_unitario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_total", default: "0.0"
    t.index ["ordem_servico_id"], name: "index_produto_items_on_ordem_servico_id"
    t.index ["produto_id"], name: "index_produto_items_on_produto_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.text "descricao"
    t.decimal "preco_compra"
    t.decimal "preco_venda"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servico_items", force: :cascade do |t|
    t.bigint "servico_id"
    t.bigint "ordem_servico_id"
    t.decimal "quantidade_horas"
    t.decimal "preco_hora"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_total", default: "0.0"
    t.index ["ordem_servico_id"], name: "index_servico_items_on_ordem_servico_id"
    t.index ["servico_id"], name: "index_servico_items_on_servico_id"
  end

  create_table "servicos", force: :cascade do |t|
    t.text "descricao"
    t.decimal "preco_hora"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "telefones", force: :cascade do |t|
    t.string "telefone"
    t.bigint "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_telefones_on_cliente_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "emails", "clientes"
  add_foreign_key "enderecos", "clientes"
  add_foreign_key "ordem_servicos", "clientes"
  add_foreign_key "ordem_servicos", "funcionarios"
  add_foreign_key "produto_items", "ordem_servicos"
  add_foreign_key "produto_items", "produtos"
  add_foreign_key "servico_items", "ordem_servicos"
  add_foreign_key "servico_items", "servicos"
  add_foreign_key "telefones", "clientes"
end
