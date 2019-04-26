# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Gerando os produtos..."
  Produto.create!([{descricao: "Pneu", preco_compra: 100, preco_venda: 160},
               {descricao: "Farol", preco_compra: 50, preco_venda: 80},
               {descricao: "Freio", preco_compra: 35, preco_venda: 65}])
puts "Gerando os produtos... [OK]"

puts "Gerando os servicos..."
  Servico.create!([{descricao: "Pintura", preco_hora: 300},
               {descricao: "Troca de óleo (carro)", preco_hora: 100},
               {descricao: "Troca de óleo (moto)", preco_hora: 20}])
puts "Gerando os servicos... [OK]"
