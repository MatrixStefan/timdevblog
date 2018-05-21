Rails.application.routes.draw do

  get 'release_note_items/new'
  get 'release_note_items/create'
  get 'release_note_items/edit'
  get 'release_note_items/update'
  get 'release_note_items/destroy'
  root to: "release_notes#index"
  devise_for :users
  resources :release_notes do
    member do
      get :publish_toggle
    end
  end

  resources :release_notes
  get "search", to: "search#search"

end
