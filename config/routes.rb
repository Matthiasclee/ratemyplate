Rails.application.routes.draw do
  resources :plates, only: %i[ index new create show ]
  get '/plates/:id/up', to: 'plates#up', as: 'up_plate'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
