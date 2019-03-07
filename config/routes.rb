Rails.application.routes.draw do
  get 'dashboard/index'

  resources :servicos
  resources :produtos
  resources :clientes
  devise_for :users

  root 'dashboard#index'
end
