json.extract! funcionario, :id, :nome, :cnpj, :email, :data_nascimento, :user_id, :created_at, :updated_at
json.url funcionario_url(funcionario, format: :json)
