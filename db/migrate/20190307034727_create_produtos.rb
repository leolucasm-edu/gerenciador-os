class CreateProdutos < ActiveRecord::Migration[5.1]
  def change
    create_table :produtos do |t|
      t.text :descricao
      t.decimal :preco_compra
      t.decimal :preco_venda

      t.timestamps
    end
  end
end
