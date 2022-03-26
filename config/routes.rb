Rails.application.routes.draw do
  resources :plates, only: %i[ index new create show ]
  get '/plates/:id/up', to: 'plates#up', as: 'up_plate'
  get '/plates/:id/new_img', to: 'plates#new_img', as: 'new_plate_image'
  post '/plates/:id/new_img', to: 'plates#add_new_img', as: 'add_new_plate_image'
  get '/static', to: 'static#get_lic_plate'
  get '/blank_plate/:state', to: 'static#get_blank_plate'
  root 'plates#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
