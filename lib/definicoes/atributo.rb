module Definicoes
  class Atributo
    include Brcobranca::Formatacao
    include ActionView::Helpers::NumberHelper

    attr_accessor :campo
    attr_accessor :nome_i18n
    attr_accessor :obrigatorio
    attr_accessor :tipo
    attr_accessor :restricao
    attr_accessor :relatorio
    attr_accessor :importacao
    attr_accessor :inscricao_online

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def nome(model)
      nome_i18n.present? ? nome_i18n : model.human_attribute_name(campo)
    end

    def visivel?(obj)
      if obj.class.name == 'Importacao'
        return false if importacao == false
        return false if campo == 'ativo' && obj.todos_ativos
        return false if campo == 'associado' && obj.todos_associados
        return false if campo == 'filiado' && obj.todos_filiados
        return visivel_restricao?(obj)
      end
      if obj.class.name.deconstantize == 'Relatorios'
        return relatorio.nil? ? visivel_restricao?(obj) : relatorio
      end
      if obj.class.name == 'ConfigAssociacaoOnline'
        return inscricao_online == 'opcional' && visivel_restricao?(obj)
      end
    end

    def visivel_restricao?(obj)
      return true if restricao.nil?
      tenant = Tenant.current_tenant.present? ? Tenant.current_tenant : obj.tenant
      if restricao == "modulo_ficha_inscricao"
        return ConfigGeral.from_tenant(tenant).first.modulo_ficha_inscricao
      else
        return restricao.include?(tenant.tipo_tenant)
      end
    end

    def get_lista(model)
      model.send("#{campo.pluralize}_i18n").invert
    end

    def formata_campo_personalizado(valor, configuracoes, outro_campo)
      valor = formata_valor(valor, configuracoes)
      valor = valor.strftime('%d/%m/%Y') if tipo == 'data' && valor.class.name == 'Date'
      if outro_campo.nil?
        return {campo.to_s => valor}.as_json
      else
        outro_campo[campo.to_s] = valor
        return outro_campo
      end
    end

    def formata_valor(valor, configuracoes)
      return valor if valor.nil?

      case tipo
      when 'currency'
        valor = valor.to_f
      when 'cpf_cnpj'
        valor = somente_numeros(valor)
        valor = case valor.length
        when 9, 10 then valor.rjust(11, '0').to_br_cpf
        when 11 then valor.to_br_cpf
        when 12, 13 then valor.rjust(14, '0').to_br_cnpj
        when 14 then valor.to_br_cnpj
        else valor # Valor inválido
        end
      when 'cei'
        valor = somente_numeros(valor)
        if valor.length == 12
          valor = valor.gsub(/^(.{3})(.{3})(.{3})(.{2})$/, '\1.\2.\3/\4')
        end
      when 'cep'
        valor = somente_numeros(valor)
        valor = valor.rjust(8, '0').to_br_cep unless valor == ""
      when 'telefone'
        valor = somente_numeros(valor) # (049) 3344-5566 => 04933445566
        valor = valor[1..-1] if valor[0] == '0' # 04933445566 => 4933445566
        valor = valor.rjust(10, '0') unless valor == "" # 3445566 => 0003445566
        valor = valor.gsub(/\A(.{2})(.{4,5})(.{4})\z/, '(\1) \2-\3') # 4933445566 => (49) 3344-5566
      when 'data'
        valor = get_valor_data(valor) if valor.class.name == 'String'
      # when 'data_hora'
      #   raise 'format_data_hora'
      when 'lista'
        configuracoes['lista'].each do |_, opcao|
          if opcao['coluna'] == valor
            valor = opcao['campo']
            break
          end
        end
      when 'pis'
        valor = somente_numeros(valor).rjust(11, '0').gsub(/^(.{3})(.{4})(.{3})(.{1})$/, '\1.\2.\3-\4')
      when 'nit'
        valor = somente_numeros(valor).rjust(11, '0').gsub(/^(.{3})(.{5})(.{2})(.{1})$/, '\1.\2.\3-\4')
      end

      return valor
    end

    def get_valor_relatorio_formatado(obj, model)
      valor = get_valor_relatorio(obj, model)
      return '' if valor.nil?
      return valor.to_s if tipo == "data" || tipo == "data_hora"
      return number_to_currency(valor, unit: "") if tipo == "currency"
      return valor
    end

    def get_valor_relatorio(obj, model)
      if campo.to_i > 0
        obj = obj.class.find(obj.id) # Retorna objeto completo, incluindo campos personalizados
        valor = obj.get CampoPersonalizado.find(campo.to_i)
        valor = get_valor_data(valor) if tipo == "data"
        valor = nil if valor == ""
        return valor
      end
      valor = case campo
      when "categoria_contribuinte_id"
        obj.categoria_contribuinte_id.nil? ? "" : obj.categoria_contribuinte.nome
      when "planoconta_id"
        obj.planoclasse_classe_s
      when "banco_id"
        obj.banco_descricao
      when "planoconta"
        unless obj.planoconta.nil?
          obj.planoconta.nome
        end
      else
        if model == "cobranca" && campo == "tipo_cobranca"
          obj.cobranca.tipo_cobranca_s
        elsif model == "dependente"
          obj.send(campo)
        elsif model == "convenio"
          if campo == "ativo"
            obj.ativo_s
          else
            obj.send(campo)
          end
        elsif model == "valor_adicional"
          if campo == "convenio"
            obj.convenio.descricao
          elsif campo == "status_convenio"
            obj.convenio.ativo_s
          else
            obj.send(campo)
          end
        else
          klass = model.classify.constantize
          if klass.method_defined? "#{campo}_i18n" # Enums (I18n)
            if obj.send("#{model}_#{campo}").present?
              klass.send("#{campo.pluralize}_i18n").values[ obj.send("#{model}_#{campo}") ]
            end
          else
            if campo.to_s.end_with?("_id")
              obj.send(campo)
            else
              obj.send("#{model}_#{campo}")
            end
          end
        end
      end
      if tipo == "data_hora"
        valor = valor.in_time_zone
      end
      if model != "convenio" && (campo == "ativo" || campo == "associado" || campo == "filiado")
        valor = valor ? "Sim" : "Não"
      end
      return valor
    end

    def get_valor_retorno(campos)
      if campo.to_i > 0
        valor = campos["campos_personalizados"][campo.to_s]
        if valor.present?
          valor = get_valor_data(valor) if tipo == "data"
          valor = CampoPersonalizadoOpcao.find(valor).descricao if tipo == "lista"
        else
          valor = nil
        end
      elsif tipo == "data"
        valor = get_valor_data(campos[campo])
      else
        valor = case campo
        when "ativo", "associado", "filiado"
          ActiveModel::Type::Boolean.new.cast(campos[campo]) ? "SIM" : "NÃO"
        when "cidade_nome"
          Cidade.find(campos["cidade_id"]).nome if campos["cidade_id"].present?
        when "cidade_uf"
          Cidade.find(campos["cidade_id"]).uf if campos["cidade_id"].present?
        when "cidade_sec_nome"
          Cidade.find(campos["cidade_id_sec"]).nome if campos["cidade_id_sec"].present?
        when "cidade_sec_uf"
          Cidade.find(campos["cidade_id_sec"]).uf if campos["cidade_id_sec"].present?
        when "estado_civil"
          Contribuinte.estados_civis_i18n[campos["estado_civil"]]
        when "categoria_contribuinte_id"
          CategoriaContribuinte.find(campos["categoria_contribuinte_id"]).nome if campos["categoria_contribuinte_id"].present?
        when "categoria_profissional"
          Contribuinte.categorias_profissionais_i18n[campos["categoria_profissional"]]
        when "naturalidade_nome"
          Cidade.find(campos["naturalidade_id"]).nome if campos["naturalidade_id"].present?
        when "naturalidade_uf"
          Cidade.find(campos["naturalidade_id"]).uf if campos["naturalidade_id"].present?
        else
          campos[campo]
        end
      end
      return valor
    end

    def somente_numeros(valor)
      valor = valor.to_i if valor.class == Float
      valor.to_s.gsub(/[^0-9]/,'')
    end

    def get_valor_data(campo)
      if campo.present?
        if campo.include?("/")
          return Date.strptime(campo, '%d/%m/%Y') rescue nil
        elsif campo.include?("-")
          return Date.strptime(campo, '%Y-%m-%d') rescue nil
        end
      end
    end

    # def required_field?(obj, attr)
    #   target = (obj.class == Class) ? obj : obj.class
    #   target.validators_on(attr).map(&:class).include?(ActiveRecord::Validations::PresenceValidator)
    # end

  end
end
