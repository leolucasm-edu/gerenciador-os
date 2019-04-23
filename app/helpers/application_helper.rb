module ApplicationHelper
  def get_valor_formatado valor
    ActionController::Base.helpers.number_to_currency(valor, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end

  def datef(date)
    date.strftime("%d/%m/%Y") if date
  end

  # Monta HTML de avisos
  def render_notices(msg)
    if notice
       raw('<p class="notice" id="notice">') + msg + raw('</p>')
    end
  end
end
