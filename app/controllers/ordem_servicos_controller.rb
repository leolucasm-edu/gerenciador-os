class OrdemServicosController < ApplicationController
  before_action :set_ordem_servico, only: [:show, :edit, :update, :destroy, :encerrar, :reabrir]
  #after_action :atualiza_valor_total, only: [:create, :update]
  before_action :authenticate_user!

  # GET /ordem_servicos
  # GET /ordem_servicos.json
  def index
    @ordem_servicos = OrdemServico.all
  end

  # GET /ordem_servicos/1
  # GET /ordem_servicos/1.json
  def show
    @operacao = 'Visualização'
  end

  # GET /ordem_servicos/new
  def new
    @operacao = 'Inclusão'
    @ordem_servico = OrdemServico.new
    @ordem_servico.servico_items.build
    @ordem_servico.produto_items.build
  end

  # GET /ordem_servicos/1/edit
  def edit
    @operacao = 'Edição'
  end

  def encerrar
    if @ordem_servico.encerrada?
      render :show, notice: 'A ordem de serviço já está encerrada'
      return
    end

    @ordem_servico.data_encerramento = Date.today
    @ordem_servico.save
    redirect_to @ordem_servico, notice: 'Ordem de serviço encerrada com  sucesso.' and return    
  end

  def reabrir
    if @ordem_servico.aberta?
      render :show, notice: 'A ordem de serviço já está aberta'
      return
    end

    @ordem_servico.data_encerramento = ''
    @ordem_servico.save
    redirect_to @ordem_servico, notice: 'Ordem de servico reaberta com sucesso.' and return

  end

  # POST /ordem_servicos
  # POST /ordem_servicos.json
  def create
    @ordem_servico = OrdemServico.new(ordem_servico_params)
    set_funcionario
    @ordem_servico.valor_total = @ordem_servico.get_valor_ordem_servico

    respond_to do |format|
      if @ordem_servico.save
        format.html { redirect_to @ordem_servico, notice: 'Ordem servico was successfully created.' }
        format.json { render :show, status: :created, location: @ordem_servico }
      else
        @ordem_servico.servico_items.build unless @ordem_servico.servico_items.size > 0
        @ordem_servico.produto_items.build unless @ordem_servico.produto_items.size > 0
        format.html { render :new }
        format.json { render json: @ordem_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordem_servicos/1
  # PATCH/PUT /ordem_servicos/1.json
  def update
    respond_to do |format|
      set_funcionario
      if @ordem_servico.update(ordem_servico_params)
        format.html { redirect_to @ordem_servico, notice: 'Ordem servico was successfully updated.' }
        format.json { render :show, status: :ok, location: @ordem_servico }
      else
        format.html { render :edit }
        format.json { render json: @ordem_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordem_servicos/1
  # DELETE /ordem_servicos/1.json
  def destroy
    @ordem_servico.destroy
    respond_to do |format|
      format.html { redirect_to ordem_servicos_url, notice: 'Ordem servico was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def atualiza_valor_total
    @ordem_servico.valor_total = @ordem_servico.get_valor_ordem_servico
    @ordem_servico.save!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordem_servico
      @ordem_servico = OrdemServico.find(params[:id])
    end

    def set_funcionario
      @funcionario = Funcionario.find_by(user_id: authenticate_user!.id)
      @ordem_servico.funcionario_id = @funcionario.id if @funcionario.present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ordem_servico_params
      params.require(:ordem_servico).permit(
        :cliente_id,
        :problema,
        :equipamento,
        :funcionario_id,
        :data_encerramento,
        :data_previsao,
        :valor_total,
        produto_items_attributes: [:id, :produto_id, :quantidade, :preco_unitario, :valor_total, :_destroy],
        servico_items_attributes: [:id, :servico_id, :quantidade_horas, :preco_hora, :valor_total, :_destroy]
      )
    end
end
