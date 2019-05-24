class ServicoItem < ApplicationRecord
  belongs_to :servico
  belongs_to :ordem_servico
end
