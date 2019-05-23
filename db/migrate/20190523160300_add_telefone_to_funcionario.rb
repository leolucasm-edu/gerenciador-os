class AddTelefoneToFuncionario < ActiveRecord::Migration[5.1]
  def change
    add_column :funcionarios, :telefone, :string
  end
end
