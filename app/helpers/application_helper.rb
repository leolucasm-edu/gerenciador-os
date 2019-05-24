module ApplicationHelper

  ESTADOS_BRASILEIROS = [
    ["Acre", "AC"],
    ["Alagoas", "AL"],
    ["Amapá", "AP"],
    ["Amazonas", "AM"],
    ["Bahia", "BA"],
    ["Ceará", "CE"],
    ["Distrito Federal", "DF"],
    ["Espírito Santo", "ES"],
    ["Goiás", "GO"],
    ["Maranhão", "MA"],
    ["Mato Grosso", "MT"],
    ["Mato Grosso do Sul", "MS"],
    ["Minas Gerais", "MG"],
    ["Pará", "PA"],
    ["Paraíba", "PB"],
    ["Paraná", "PR"],
    ["Pernambuco", "PE"],
    ["Piauí", "PI"],
    ["Rio de Janeiro", "RJ"],
    ["Rio Grande do Norte", "RN"],
    ["Rio Grande do Sul", "RS"],
    ["Rondônia", "RO"],
    ["Roraima", "RR"],
    ["Santa Catarina", "SC"],
    ["São Paulo", "SP"],
    ["Sergipe", "SE"],
    ["Tocantins", "TO"]
  ]

  def options_for_states(selected)
    options_for_select(ESTADOS_BRASILEIROS, selected)
  end

  def get_valor_formatado valor
    ActionController::Base.helpers.number_to_currency(valor, :unit => "R$ ", :separator => ",", :delimiter => ".")
  end

  def datef(date)
    return "" if date = ""
    date.strftime("%d/%m/%Y") if date
  end

  # Monta HTML de avisos
  def render_notices(msg)
    if notice
       raw('<p class="notice" id="notice">') + msg + raw('</p>')
    end
  end

  # Monta HTML de alertas
  def render_alerts(obj)

    if obj.errors.any?

       html =
          raw('<div class="row">') +
          raw('<div class="content-alerts col-md-6">') +
          raw('<div class="alert alert-error">') +
          raw('<h4>') + pluralize(obj.errors.count, "erro", "erros") +
            ' ' + "encontrado".pluralize(obj.errors.count) +
            raw(':</h4>') +
          raw('<ul>');

       obj.errors.full_messages.each do |msg|
          html += raw('<li>') + msg + raw('</li>')
       end

       html +=
          raw('</ul>') +
          raw('</div>') +
          raw('</div>') +
          raw('</div>');

       return html;

    end
  end

  # Monta HTML de avisos
  def render_notices(msg)
    if notice
       raw('<div class="row"><p class="notice col-md-6" id="notice">') + msg + raw('</p></div>')
    end
  end
end
