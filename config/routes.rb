Rails.application.routes.draw do

  devise_for :users
  resources :release_notes

end
