class CreateClientes < ActiveRecord::Migration[5.1]
  def change
    create_table :clientes do |t|
      t.text :nome
      t.text :cpf_cnpj
      t.date :data_nascimento

      t.timestamps
    end
  end
end
