Rails.application.routes.draw do
  resources :produtos do
  	resources :upsell do
      resources :promocoes
    end
  	resources :paginas
  end
  resources :administradores
  root to: 'produtos#index'

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'

  get '/login', to: 'login#index'

  get '/upsell/:pagina_id', to: 'funil#upsell'

  post '/99run/login/comprar/grupo-corrida', to: 'acao99run#login_compra_grupo_corrida'
  post '/99run/inscricao-email', to: 'acao99run#captura_email'
  post '/99run/inscricao-telefone', to: 'acao99run#captura_telefone'
  
  get '/:slug_produto/:slug_pagina', to: 'funil#slug'
end
