Rails.application.routes.draw do

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
  get '/update' => 'users#update', as: :update_false_users
  patch '/update' => 'users#update', as: :update_users
  get '/unsubscribe' => 'users#unsubscribe', as: :unsubscribe_users
  patch '/withdraw' => "users#withdraw", as: :withdraw_users
  get '/users' => 'users#index', as: :index_users
  get '/users/:id' => 'users#show', as: :show_users
  get '/posts/:post_id/post_comments/search' => 'post_comments#search', as: :search_comments
  get '/genres/:id/search' => 'genres#seek', as: :genre_seek
  get '/genres/:genre_id/genre_details/search' => 'genre_details#search', as: :search_genre_details
  get '/post_comments' => 'post_comments#select', as: :post_comments_all
  get '/genre_details' => 'genre_details#select', as: :genre_details_all
  get '/post_comments/search' => 'post_comments#seek', as: :post_comments_seek
  get '/genre_details/search' => 'genre_details#seek', as: :genre_details_seek
  get '/contacts' => 'contacts#create', as: :contacts
  get '/posts/new/search' => 'posts#search_new', as: :search_new
  get '/posts/:id/edit/search' => 'posts#search_edit', as: :search_edit

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

  resources :contacts, only: [:new, :create] do
    collection do
      get :confirm
      post :confirm
      get :back
      post :back
      get :complete
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
