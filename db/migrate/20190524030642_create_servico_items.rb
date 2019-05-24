class CreateServicoItems < ActiveRecord::Migration[5.1]
  def change
    create_table :servico_items do |t|
      t.references :servico, foreign_key: true
      t.references :ordem_servico, foreign_key: true
      t.decimal :quantidade_horas
      t.decimal :preco_hora

      t.timestamps
    end
  end
end
