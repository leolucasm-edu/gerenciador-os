class CreateOrdemServicos < ActiveRecord::Migration[5.1]
  def change
    create_table :ordem_servicos do |t|
      t.references :cliente, foreign_key: true
      t.text :problema
      t.string :equipamento
      t.references :funcionario, foreign_key: true
      t.string :data_abertura
      t.string :data_encerramento
      t.string :data_previsao

      t.timestamps
    end
  end
end
