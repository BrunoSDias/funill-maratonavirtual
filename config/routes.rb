Rails.application.routes.draw do
  get '/chamadas/sintetico', to: 'chamadas#sintetico'
  
  resources :chamadas
  root to: "chamadas#index"
  resources :administradores

  get '/login', to: 'login#index'
  post '/login', to: 'login#logar'
  get '/sair', to: 'login#deslogar'
end
