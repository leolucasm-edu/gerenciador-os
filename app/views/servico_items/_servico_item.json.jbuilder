json.extract! servico_item, :id, :servico_id, :ordem_servico_id, :quantidade_horas, :preco_hora, :created_at, :updated_at
json.url servico_item_url(servico_item, format: :json)
