class OrdemServico < ApplicationRecord
  belongs_to :cliente
  belongs_to :funcionario
end
