Rails.application.routes.draw do
  resources :produtos do
  	resources :upsell do
      resources :promocoes
    end
  	resources :paginas
  end
  resources :administradores
  root to: 'administradores#index'

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'

  get '/login', to: 'login#index'

  get '/:slug_produto/:slug_pagina', to: 'funil#slug'
end
