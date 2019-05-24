class RelatorioController < ApplicationController
  def filtro
    @data_inicial = Date.today
    @data_final = Date.today
    @status = ''
  end

  def gerar
    @filtro_status = ''
    @filtro_status = " and (data_encerramento != '' and data_encerramento is not null)" if params[:status] == "encerradas"
    @filtro_status = " and (data_encerramento is null or data_encerramento = '')" if params[:status] == "abertas"

    @ordens_servico = OrdemServico.where("created_at BETWEEN '#{params[:data_inicial]}' and '#{params[:data_final]}' #{@filtro_status}")    
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def relatorio_params
      params.require(:relatorio).permit(
        :data_inicial,
        :data_final,
        :status
      )
    end
end
