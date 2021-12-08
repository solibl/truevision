Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  
  devise_for :users
  get  'create_new_user',  to: 'users#new'
  post 'create_new_user',  to: 'users#create'

  get  'edit_location', to: 'locations#edit'
  patch  'edit_location', to: 'locations#update'
end
