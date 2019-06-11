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

  get '/upsell/:pagina_id', to: 'funil#upsell'
  post '/99run/login/comprar/grupo-corrida', to: 'acao99run#login_compra_grupo_corrida'
  get '/:slug_produto/:slug_pagina', to: 'funil#slug'
end
