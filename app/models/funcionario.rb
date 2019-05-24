class Funcionario < ApplicationRecord
  before_create :formata_cpf, :valida_data_nascimento
  before_update :formata_cpf, :valida_data_nascimento

  validates_presence_of :nome
  validates_presence_of :cnpj
  validates_presence_of :data_nascimento
  validates_presence_of :telefone
  validates :cnpj, :cpf => true  

  def formata_cpf
    return self.cnpj if self.cnpj.nil?
    self.cnpj = self.cnpj.to_s.gsub(/[^0-9]/,'')
    self.cnpj = self.cnpj.gsub(/^(.{3})(.{3})(.{3})(.{2})$/, '\1.\2.\3-\4')
  end

  def valida_data_nascimento
    return self.data_nascimento if self.data_nascimento.nil?

    if self.data_nascimento.to_date >= Date.today
      self.errors[:data_nascimento] << "deve ser menor que data atual"
    end
  end

end
