Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create' 
  resources :todos do
    resources :items
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
