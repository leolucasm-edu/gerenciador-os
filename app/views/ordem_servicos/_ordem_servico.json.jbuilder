json.extract! ordem_servico, :id, :cliente_id, :problema, :equipamento, :funcionario_id, :data_abertura, :data_encerramento, :data_previsao, :created_at, :updated_at
json.url ordem_servico_url(ordem_servico, format: :json)
