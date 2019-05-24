class OrdemServico < ApplicationRecord
  has_many :servico_items, dependent: :destroy
  has_many :produto_items, dependent: :destroy
  belongs_to :cliente
  belongs_to :funcionario
  accepts_nested_attributes_for :servico_items, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :produto_items, reject_if: :all_blank, allow_destroy: true

  before_create :valida_data_previsao
  before_update :valida_data_previsao

  validates :cliente_id, presence: true
  validates :data_previsao, presence: true
  validates :cliente_id, presence: true
  validates :valor_total, :numericality => { :greater_than => 0, message: "deve ser maior que R$0,00"}  
  validates_presence_of :servico_items

  def encerrada?
    self.data_encerramento.present?
  end

  def aberta?
    !self.data_encerramento.present?
  end

  def get_status
    return 'Encerrada' if self.encerrada?
    return 'Aberta' if self.aberta?
  end

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

  def valida_data_previsao
    return self.data_previsao if self.data_previsao.nil?

    if self.data_previsao.to_date <= Date.today
      self.errors[:data_previsao] << "deve ser maior que data atual"
    end
  end
end
