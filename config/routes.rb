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
  get 'data-sheet-index', to: 'data_sheets#index'
  get 'new-data-sheet-index/:tray', to: 'data_sheets#new', as: 'new_data_sheet_index'
  post 'new-data-sheet-index/:tray', to: 'data_sheets#create'
  post 'mark-sheet-for-outlier/:data_sheet', to: 'data_sheets#mark_sheet_for_outlier', as: 'mark_sheet_for_outlier'

  #Data Entries
  get 'data-sheet/:data_sheet', to: 'data_entries#new', as: 'new_data_entry'
  get 'edit-data-entry/:data_entry', to: 'data_entries#edit', as: 'edit_data_entry'
  patch 'edit_data_entry', to: 'data_entries#edit_update'
  post  'new-data-entry/:data_sheet', to: 'data_entries#create'

  #Watering Que
  get 'watering-que', to: 'data_sheets#watering_que'
  post 'manual-feed/:data_sheet', to: 'data_entries#manual_feed', as: 'manual_feed'
  post 'update-data-entry', to: 'data_entries#update', as: 'update_data_entry'

  #Transplanting Que
  get 'transplanting-que', to: 'data_sheets#transplanting_que'
  post 'update-transplanting-que/:data_sheet', to: 'data_sheets#update_transplanting_que', as: 'update_data_sheet_transplanting'
  post 'complete-transplanting-que/:strain', to: 'data_sheets#update_transplanted', as: 'update_data_sheet_transplanted'

  #Kill Tray
  post 'kill-tray/:data_sheet', to: 'data_sheets#kill_tray', as: 'kill_tray'

  #Strains
  get 'strain-index', to: 'strains#index', as: 'strain_index'
  get 'strain/:strain', to: 'strains#info', as: 'strain'
end
