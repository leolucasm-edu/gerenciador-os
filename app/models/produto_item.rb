class ProdutoItem < ApplicationRecord
  belongs_to :produto
  belongs_to :ordem_servico

  def recalcula_total
    return false unless self.present?
    self.valor_total = self.quantidade * self.preco_unitario
  end
end
