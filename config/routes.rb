Rails.application.routes.draw do
  resources :produtos do
  	resources :upsell
  	resources :paginas
  end
  resources :administradores
  root to: 'administradores#index'

  root to: 'administradores#index'
  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'
end
