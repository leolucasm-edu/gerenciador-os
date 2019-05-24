class ServicoItem < ApplicationRecord
  belongs_to :servico
  belongs_to :ordem_servico
  
  validates :servico, presence: true
  validates :quantidade_horas, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}
  validates :preco_hora, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}
  validates :valor_total, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}

  def recalcula_total
    return false unless self.present?
    self.valor_total = self.quantidade_horas * self.preco_hora
  end
end
