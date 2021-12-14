Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  
  #Users
  devise_for :users
  get  'create_new_user',  to: 'users#new'
  post 'create_new_user',  to: 'users#create'

  #Locations
  get  'edit_location', to: 'locations#edit'
  patch  'edit_location', to: 'locations#update'

  #Clone Feeds
  get  'edit_clone_feed', to: 'clone_feeds#edit'
  post  'edit_clone_feed', to: 'clone_feeds#update'

  #Data Sheets
  get 'data_sheet_index', to: 'data_sheets#index'
  get 'new_data_sheet_index/:tray', to: 'data_sheets#new', as: 'new_data_sheet_index'
  post 'new_data_sheet_index/:tray', to: 'data_sheets#create'

  #Data Entries
  get 'data_sheet/:data_sheet', to: 'data_entries#new', as: 'new_data_entry'
end
