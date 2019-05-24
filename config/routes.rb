Rails.application.routes.draw do
  resources :servico_items
  resources :produto_items
  resources :ordem_servicos
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

  get 'search/ajax_search'
  get 'search/search_by_id'
  get 'search/ajax_search_externo'
end
