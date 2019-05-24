class ProdutoItem < ApplicationRecord
  belongs_to :produto
  belongs_to :ordem_servico
end
