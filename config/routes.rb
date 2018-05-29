Rails.application.routes.draw do
  
  root to: "release_notes#index"
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :release_notes do
    member do
      get :publish_toggle
      get :notify
      get :enhancements
      get :bug_fixes
    end
  end
  
  get "new_features", to: "release_notes#new_features"
  get "enhancements", to: "release_notes#enhancements"
  get "bug_fixes", to: "release_notes#bug_fixes"

  get "search", to: "search#search"

end
