Rails.application.routes.draw do
  resources :funcionarios
  resources :emails
  resources :enderecos
  resources :telefones
  get 'dashboard/index'

  resources :servicos
  resources :produtos
  resources :clientes
  devise_for :users

  root 'dashboard#index'
end
