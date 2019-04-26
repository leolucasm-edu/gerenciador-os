class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    @operacao = "Visualização"
  end

  # GET /clientes/new
  def new
    @operacao = "Inclusão"
    @cliente = Cliente.new
    @cliente.build_endereco
    @cliente.telefones.build
    @cliente.emails.build
  end

  # GET /clientes/1/edit
  def edit
    @operacao = "Edição"
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)    

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: t('messages.cadastro_salvo') }
        format.json { render :show, status: :created, location: @cliente }
      else
        @cliente.telefones.build unless @cliente.telefones.size > 0
        @cliente.emails.build unless @cliente.emails.size > 0
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to @cliente, notice: t('messages.cadastro_atualizado') }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente.destroy
    respond_to do |format|
      format.html { redirect_to clientes_url, notice: t('messages.cadastro_removido')}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cliente_params
      params.require(:cliente).permit(
        :nome,
        :cpf_cnpj,
        :data_nascimento,
        endereco_attributes: [:rua, :cidade, :estado, :numero, :cep, :complemento, :bairro],
        telefones_attributes: [:id, :telefone, :_destroy],
        emails_attributes: [:id, :email, :_destroy]
      )
    end
end
