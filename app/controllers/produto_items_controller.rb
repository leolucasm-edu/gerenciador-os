class ProdutoItemsController < ApplicationController
  before_action :set_produto_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /produto_items
  # GET /produto_items.json
  def index
    @produto_items = ProdutoItem.all
  end

  # GET /produto_items/1
  # GET /produto_items/1.json
  def show
  end

  # GET /produto_items/new
  def new
    @produto_item = ProdutoItem.new
  end

  # GET /produto_items/1/edit
  def edit
  end

  # POST /produto_items
  # POST /produto_items.json
  def create
    @produto_item = ProdutoItem.new(produto_item_params)
    @produto_item.recalcula_total
    respond_to do |format|
      if @produto_item.save
        format.html { redirect_to @produto_item, notice: 'Produto item was successfully created.' }
        format.json { render :show, status: :created, location: @produto_item }
      else
        format.html { render :new }
        format.json { render json: @produto_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produto_items/1
  # PATCH/PUT /produto_items/1.json
  def update
    respond_to do |format|
      if @produto_item.update(produto_item_params)
        @produto_item.recalcula_total
        @produto_item.save!
        format.html { redirect_to @produto_item, notice: 'Produto item was successfully updated.' }
        format.json { render :show, status: :ok, location: @produto_item }
      else
        format.html { render :edit }
        format.json { render json: @produto_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produto_items/1
  # DELETE /produto_items/1.json
  def destroy
    @produto_item.destroy
    respond_to do |format|
      format.html { redirect_to produto_items_url, notice: 'Produto item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produto_item
      @produto_item = ProdutoItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produto_item_params
      params.require(:produto_item).permit(:produto_id, :ordem_servico_id, :quantidade, :preco_unitario, :valor_total)
    end
end
