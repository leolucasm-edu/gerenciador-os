class Servico < ApplicationRecord
  validates :descricao, presence: true
  validates :preco_hora, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}
end
