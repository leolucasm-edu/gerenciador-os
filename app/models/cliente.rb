class Cliente < ApplicationRecord
  has_many :telefones, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_one :endereco, dependent: :destroy

  accepts_nested_attributes_for :telefones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :endereco

  validates_presence_of :nome
  validates_presence_of :cpf_cnpj
  validates_presence_of :data_nascimento, :if=> :valida_nascimento?
  validates_presence_of :telefones
  validates_presence_of :emails
  validates :cpf_cnpj, :cpf_or_cnpj => true

  def valida_nascimento?
    # CPF Formatado
    cpf_cnpj.length == 14
  end

end
