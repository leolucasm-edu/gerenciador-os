class Produto < ApplicationRecord
  validates :descricao, presence: true
end
