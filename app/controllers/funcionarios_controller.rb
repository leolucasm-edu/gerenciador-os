class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /funcionarios
  # GET /funcionarios.json
  def index
    @funcionarios = Funcionario.all
    @users = User.all
  end

  # GET /funcionarios/1
  # GET /funcionarios/1.json
  def show
    @operacao = 'Visualização'
  end

  # GET /funcionarios/new
  def new
    @operacao = 'Inclusão'
    @funcionario = Funcionario.new
    @user = User.new
  end

  # GET /funcionarios/1/edit
  def edit
    @operacao = 'Edição'
  end

  # POST /funcionarios
  # POST /funcionarios.json
  def create
    @user = User.new(user_params)

    if @user.email.blank?
      @user.errors.add(:email, :blank)
    elsif User.where("lower(email) = ?", @user.email.downcase).first
      @user.errors.add(:email, :taken)
    end

    @funcionario = Funcionario.new(funcionario_params)
    unless @user.errors.empty? && @funcionario.validate
      render :new and return
    end

    User.transaction do
      if @user.save()
        @funcionario.user_id = @user.id
        @funcionario.save!
        flash[:notice] = "Novo funcionário cadastrado."
        redirect_to funcionarios_path and return
      end
      raise ActiveRecord::Rollback
    end
    render :new and return

  end

  # PATCH/PUT /funcionarios/1
  # PATCH/PUT /funcionarios/1.json
  def update
    if User.where("LOWER(email) = ?", params[:user][:email].downcase).where.not(id: @user.id).first.present?
      @user.errors.add :email, :taken
      render :edit and return
    end

    if @funcionario.update(funcionario_params) && @user.update(user_params)
      redirect_to funcionarios_path, notice: 'Alteração realizada com sucesso!'
    else
      render :edit
    end
  end

  # DELETE /funcionarios/1
  # DELETE /funcionarios/1.json
  def destroy
    User.transaction do
      @user.destroy
      @funcionario.destroy
      respond_to do |format|
        format.html { redirect_to funcionarios_url, notice: 'Funcionario excluído com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funcionario
      @funcionario = Funcionario.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.where(id: @funcionario.user_id).first
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def funcionario_params
      params.require(:funcionario).permit(:nome, :cnpj, :data_nascimento, :telefone, :user_id)
    end
end
