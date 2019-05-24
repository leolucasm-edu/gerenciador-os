class ServicoItemsController < ApplicationController
  before_action :set_servico_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /servico_items
  # GET /servico_items.json
  def index
    @servico_items = ServicoItem.all
  end

  # GET /servico_items/1
  # GET /servico_items/1.json
  def show
  end

  # GET /servico_items/new
  def new
    @servico_item = ServicoItem.new
  end

  # GET /servico_items/1/edit
  def edit
  end

  # POST /servico_items
  # POST /servico_items.json
  def create
    @servico_item = ServicoItem.new(servico_item_params)
    @servico_item.recalcula_total

    respond_to do |format|
      if @servico_item.save
        format.html { redirect_to @servico_item, notice: 'Servico item was successfully created.' }
        format.json { render :show, status: :created, location: @servico_item }
      else
        format.html { render :new }
        format.json { render json: @servico_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servico_items/1
  # PATCH/PUT /servico_items/1.json
  def update
    respond_to do |format|
      if @servico_item.update(servico_item_params)
        @servico_item.recalcula_total
        @servico_item.save!
        format.html { redirect_to @servico_item, notice: 'Servico item was successfully updated.' }
        format.json { render :show, status: :ok, location: @servico_item }
      else
        format.html { render :edit }
        format.json { render json: @servico_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servico_items/1
  # DELETE /servico_items/1.json
  def destroy
    @servico_item.destroy
    respond_to do |format|
      format.html { redirect_to servico_items_url, notice: 'Servico item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servico_item
      @servico_item = ServicoItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servico_item_params
      params.require(:servico_item).permit(:servico_id, :ordem_servico_id, :quantidade_horas, :preco_hora)
    end
end
