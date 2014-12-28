DotGridRails::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  post '/documents/generate_and_send', to: 'documents#generate_and_send', :constraints => {:format => /js/}
  post '/documents/update', to: 'documents#update', :constraints => {:format => /js/}
  resources :documents, only: [:create, :destroy, :edit] do
    member do
      post :update
    end
  end

  root  'static_pages#home'

  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
