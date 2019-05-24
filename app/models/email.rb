class Email < ApplicationRecord
  belongs_to :cliente

  validates_format_of :email, with: /\A(\s*[\w\.\-+]+@[\-\w]+(\.[\-\w]+)+\s*)(;\s*[\w\.\-+]+@[\-\w]+(\.[\-\w]+)+\s*)*\z/i
end
