class OrdemServico < ApplicationRecord
  has_many :servico_items, dependent: :destroy
  has_many :produto_items, dependent: :destroy
  belongs_to :cliente
  belongs_to :funcionario

  accepts_nested_attributes_for :servico_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :produto_items, reject_if: :all_blank, allow_destroy: true

  def get_valor_ordem_servico
    valor = 0    
    return valor unless self.present?

    if self.produto_items.present?
      self.produto_items.each do |prod|
        valor += prod.quantidade * prod.preco_unitario if prod.quantidade.present?
      end
    end

    if self.servico_items.present?
      self.servico_items.each do |s|
        valor += s.quantidade_horas * s.preco_hora if s.quantidade_horas.present?
      end
    end
  end
end
