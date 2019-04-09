Rails.application.routes.draw do
  resources :chamadas
  root to: "chamadas#index"
  resources :administradores

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'
end
