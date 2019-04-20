module ApplicationHelper
  def get_valor_formatado valor
    ActionController::Base.helpers.number_to_currency(valor, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end
end
