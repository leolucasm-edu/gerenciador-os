json.extract! produto, :id, :descricao, :preco_compra, :preco_venda, :created_at, :updated_at
json.url produto_url(produto, format: :json)
