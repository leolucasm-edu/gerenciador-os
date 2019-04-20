json.extract! servico, :id, :descricao, :preco_hora, :created_at, :updated_at
json.url servico_url(servico, format: :json)
