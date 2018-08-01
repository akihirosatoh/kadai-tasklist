Rails.application.routes.draw do
  get 'task_managers/create'

  get 'task_managers/destroy'

#  get 'sessions/new'

#  get 'sessions/create'

#  get 'sessions/destroy'

#  get 'users/index'

#  get 'users/show'

#  get 'users/new'

#  get 'users/create'

#  get 'toppages/index'

#  resources :tasks
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  get 'user', to: 'toppages#index'
  resources :users, only: [:index, :new, :create]
  
  resources :task_managers, only: [:create, :destroy, :edit]
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
