json.extract! cliente, :id, :nome, :cpf_cnpj, :data_nascimento, :email, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
