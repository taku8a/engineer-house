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
    get "join" => "projects#join"
    get "leave" => "projects#leave"
    resources :project_chats, only: [:index, :create]
  end

  get '/mypage' => 'users#show', as: :mypage_users
  get '/edit' => 'users#edit', as: :edit_users
  patch '/update' => 'users#update', as: :update_users
  get '/unsubscribe' => 'users#unsubscribe', as: :unsubscribe_users
  patch '/withdraw' => "users#withdraw", as: :withdraw_users

  # resource :project_chat, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
