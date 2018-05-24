Rails.application.routes.draw do
  
  root to: "release_notes#index"
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :release_notes do
    member do
      get :publish_toggle
      get :notify
    end
  end

  resources :release_notes
  get "search", to: "search#search"

end
