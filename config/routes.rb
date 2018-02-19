Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', :registrations => 'registrations' }

  # root to: 'messages#index'
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :messages do
    collection do
      get :search
    end
  end

  resources :likes, only: %i[create destroy]

  mount ActionCable.server => '/cable'
end
