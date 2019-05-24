json.extract! produto_item, :id, :produto_id, :ordem_servico_id, :quantidade, :preco_unitario, :created_at, :updated_at
json.url produto_item_url(produto_item, format: :json)
