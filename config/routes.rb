Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: [:show, :index]
      resources :videos, only: [:show]
      resources :bookmarks, only: [:create]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  get '/auth/developer', as: :developer_auth
  get '/auth/github', as: :github_auth
  get '/auth/github/callback', to: 'users#update'
  delete '/auth/github', to: 'users#destroy'

  get "/invite", to: 'invite#new'
  post "/invite/create", to: 'invite#create'

  resources :friendships, only: [:create]
  delete '/friendship', to: 'friendships#destroy'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, except: [:index, :show] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index, :destroy] do
    resources :videos, only: [:show, :index, :destroy]
  end

  resources :user_videos, only:[:create, :destroy]

  get '/activator/:id', to: 'activator#update'
end
