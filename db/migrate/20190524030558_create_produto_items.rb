class CreateProdutoItems < ActiveRecord::Migration[5.1]
  def change
    create_table :produto_items do |t|
      t.references :produto, foreign_key: true
      t.references :ordem_servico, foreign_key: true
      t.decimal :quantidade
      t.decimal :preco_unitario

      t.timestamps
    end
  end
end
