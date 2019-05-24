class ServicoItem < ApplicationRecord
  belongs_to :servico
  belongs_to :ordem_servico

  def recalcula_total
    return false unless self.present?
    self.valor_total = self.quantidade_horas * self.preco_hora
  end
end
