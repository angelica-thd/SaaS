Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'auth/login', to: 'authentication#authenticate'
  get 'auth/logout', to: 'authentication#destroy'
  post 'signup', to: 'users#create'
  get 'me', to: 'users#me'
  put 'update', to: 'users#update'
  delete 'delete', to: 'users#destroy'
  post 'signup/student', to: 'students#create'
  post 'find/student', to: 'students#show'
  put 'update/student', to: 'students#update'
  delete 'delete/student', to: 'students#destroy'

  resources :todos do
    resources :items
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
