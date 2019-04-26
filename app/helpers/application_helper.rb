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
    date.strftime("%d/%m/%Y") if date
  end

  # Monta HTML de avisos
  def render_notices(msg)
    if notice
       raw('<p class="notice" id="notice">') + msg + raw('</p>')
    end
  end
end
