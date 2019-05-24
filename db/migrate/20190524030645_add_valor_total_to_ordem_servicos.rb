class AddValorTotalToOrdemServicos < ActiveRecord::Migration[5.1]
  def change
    add_column :ordem_servicos, :valor_total, :decimal
  end
end
