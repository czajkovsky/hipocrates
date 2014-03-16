Hipocrates::Application.routes.draw do

  root to: 'dashboard#index'

  resources :users do
    collection do
      get 'register'
    end
    member do
      get 'confirmation'
    end
  end
  resources :roles, except: :show
  resources :specialities, except: :show

  get 'patients', to: 'users#patients'
  get 'stuff', to: 'users#stuff'

  resources :sessions
  get 'sign_up', to: 'users#register', as: 'sign_up'
  get 'log_in', to: 'sessions#new', as: 'log_in'
  get 'log_out', to: 'sessions#destroy', as: 'log_out'

end
