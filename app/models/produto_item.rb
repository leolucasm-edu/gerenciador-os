class ProdutoItem < ApplicationRecord
  belongs_to :produto
  belongs_to :ordem_servico

  validates :produto, presence: true
  # validates :quantidade, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}
  # validates :preco_unitario, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}
  # validates :valor_total, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}

  def recalcula_total
    return false unless self.present?
    self.valor_total = self.quantidade * self.preco_unitario
  end
end
