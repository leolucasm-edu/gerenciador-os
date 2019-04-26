class Endereco < ApplicationRecord
  belongs_to :cliente
  before_create :formata_cep
  before_update :formata_cep

  validates_presence_of :rua, :cidade, :estado, :numero, :cep, :bairro

  def formata_cep
    return self.cep if self.cep.nil?
    self.cep = self.cep.to_s.gsub(/[^0-9]/,'')
    self.cep = self.cep.gsub(/^(.{5})(.{3})$/, '\1-\2')
  end
end
