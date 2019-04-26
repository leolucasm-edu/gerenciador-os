class CreateEnderecos < ActiveRecord::Migration[5.1]
  def change
    create_table :enderecos do |t|
      t.string :rua
      t.string :cidade
      t.string :estado
      t.string :cep
      t.string :numero
      t.string :bairro
      t.string :complemento
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
