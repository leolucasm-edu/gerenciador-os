class AddValorTotalToServicoItem < ActiveRecord::Migration[5.1]
  def change
    add_column :servico_items, :valor_total, :decimal, default: 0
  end
end
