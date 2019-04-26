json.extract! endereco, :id, :rua, :cidade, :state, :cep, :numero, :bairro, :complemento, :cliente_id, :created_at, :updated_at
json.url endereco_url(endereco, format: :json)
