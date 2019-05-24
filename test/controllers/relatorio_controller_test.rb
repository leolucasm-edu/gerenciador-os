require 'test_helper'

class RelatorioControllerTest < ActionDispatch::IntegrationTest
  test "should get filtro" do
    get relatorio_filtro_url
    assert_response :success
  end

  test "should get gerar" do
    get relatorio_gerar_url
    assert_response :success
  end

end
