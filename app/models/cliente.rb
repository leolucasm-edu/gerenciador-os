class Cliente < ApplicationRecord
  has_many :telefones
  has_many :emails
  has_one :endereco

  accepts_nested_attributes_for :telefones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :endereco
end
