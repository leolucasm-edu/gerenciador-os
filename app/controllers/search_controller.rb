class SearchController < ApplicationController
  before_action :authenticate_user!, only: [:ajax_search, :search_by_id, :ajax_search_externo]
  before_action :set_term, only: [:index, :search]

  def index
    if !@term.blank?
      @clientes = search('Cliente')
      @produtos = search('Produto')
      @servicos = search('Servico')
    end
  end

  def ajax_search
    model = params[:model]
    campo = params[:campo].to_sym
    termo = I18n.transliterate(params[:termo]).downcase

    @resultados = model.constantize
      .limit(params[:pageLimit])
      .order(campo)

    case model
    when 'Cliente'
      @resultados = @resultados.where( "UNACCENT(LOWER(#{campo})) LIKE ? OR "\
        "UNACCENT(LOWER(nome)) LIKE ? OR "\
        "UNACCENT(LOWER(cpf_cnpj)) LIKE ?",
        "%#{termo}%", "%#{termo}%", "%#{termo}%" )
    when 'Produto'
      @resultados = @resultados.where( "UNACCENT(LOWER(#{campo})) LIKE ?", "%#{termo}%" )
    when 'Servico'
      @resultados = @resultados.where( "UNACCENT(LOWER(#{campo})) LIKE ?", "%#{termo}%")
    end

    respond_to do |format|
       format.json { render json: @resultados }
    end
  end

  def search_by_id
    model = params[:model]
    @resultado = model.constantize.find(params[:id])

    respond_to do |format|
       format.json { render json: @resultado }
    end
  end

  private

  def search(model)
    klass = model.constantize
    table = model.tableize
    termo = "%" + I18n.transliterate(@term).downcase + "%"
    return klass.where(
        'UNACCENT(LOWER("clientes"."razao_social")) LIKE ? OR '\
        'UNACCENT(LOWER("entidades"."nome")) LIKE ? OR '\
        'UNACCENT(LOWER("entidades"."email")) LIKE ? OR '\
        'UNACCENT(LOWER("entidades"."telefone")) LIKE ? OR '\
        'UNACCENT(LOWER("entidades"."cpf_cnpj")) LIKE ?',
        termo, termo, termo, termo, termo
      ).includes(:cidade)
  end

  def set_term
    @term = params[:term].strip if params[:term].present?
  end

end
