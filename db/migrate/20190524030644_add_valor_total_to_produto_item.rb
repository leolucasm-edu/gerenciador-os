class AddValorTotalToProdutoItem < ActiveRecord::Migration[5.1]
  def change
    add_column :produto_items, :valor_total, :decimal
  end
end
