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
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
