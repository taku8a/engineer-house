Rails.application.routes.draw do

  # devise_for :users, controllers: {
  #   registrations: "users/registrations",
  #   sessions: "users/sessions"
  # }
  devise_for :users, skip: :all
  devise_scope :user do
    get '/sign_in' => 'users/sessions#new', as: :new_user_session
    post '/sign_in' => 'users/sessions#create', as: :user_session
    delete '/sign_out' => 'users/sessions#destroy', as: :destroy_user_session
    get '/sign_up' => 'users/registrations#new', as: :new_user_registration
    post '/sign_up' => 'users/registrations#create', as: :user_registration
  end

  root :to => "homes#top"
  get "/about" => "homes#about"
  resources :projects do
    collection do
      get 'search'
    end
    get "join" => "projects#join"
    get "leave" => "projects#leave"
    resources :project_chats, only: [:index, :create]
  end

  get '/search' => 'users#search', as: :search_users
  get '/mypage' => 'users#mypage', as: :mypage_users
  get '/edit' => 'users#edit', as: :edit_users
  patch '/update' => 'users#update', as: :update_users
  get '/unsubscribe' => 'users#unsubscribe', as: :unsubscribe_users
  patch '/withdraw' => "users#withdraw", as: :withdraw_users
  get '/user' => 'users#index', as: :index_users
  get '/user/:id' => 'users#show', as: :show_users
  get '/posts/:post_id/post_comments/search' => 'post_comments#search', as: :search_comments
  get '/genres/:genre_id/genre_details/search' => 'genre_details#search', as: :search_genre_details
  
  resources :posts do
    collection do
      get 'search'
    end
    resources :post_comments
  end

  resources :genres, except: [:new, :destroy] do
    collection do
      get 'search'
    end
    resources :genre_details, except: [:destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
