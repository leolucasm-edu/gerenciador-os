class Cliente < ApplicationRecord
  has_many :telefones, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_one :endereco, dependent: :destroy
  before_create :formata_cpf_cnpj
  before_update :formata_cpf_cnpj

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

  def formata_cpf_cnpj
    return self.cpf_cnpj if self.cpf_cnpj.nil?
    self.cpf_cnpj = self.cpf_cnpj.to_s.gsub(/[^0-9]/,'')
    self.cpf_cnpj = case self.cpf_cnpj.length
    when 11 then self.cpf_cnpj.gsub(/^(.{3})(.{3})(.{3})(.{2})$/, '\1.\2.\3-\4')
    when 14 then self.cpf_cnpj.gsub(/^(.{2})(.{3})(.{3})(.{4})(.{2})$/, '\1.\2.\3/\4-\5')
    end
  end

end
