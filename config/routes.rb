Rails.application.routes.draw do
  # get 'project_chats/new'
  # get 'project_chats/create'
  # get 'projects/index'
  # get 'projects/show'
  # get 'projects/edit'
  # get 'projects/new'
  # get 'projects/create'
  # get 'projects/update'
  # get 'projects/destroy'
  # get 'homes/top'
  # get 'homes/about'

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
  end
  resource :project_chat, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
