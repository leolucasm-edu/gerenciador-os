class CreateFuncionarios < ActiveRecord::Migration[5.1]
  def change
    create_table :funcionarios do |t|
      t.string :nome
      t.string :cnpj
      t.string :email
      t.string :data_nascimento
      t.integer :user_id

      t.timestamps
    end
  end
end
