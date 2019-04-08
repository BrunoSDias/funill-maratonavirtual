Rails.application.routes.draw do
  root to: "administradores#index"
  resources :administradores

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'
end
