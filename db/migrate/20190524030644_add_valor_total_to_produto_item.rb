class AddValorTotalToProdutoItem < ActiveRecord::Migration[5.1]
  def change
    add_column :produto_items, :valor_total, :decimal, default: 0
  end
end
