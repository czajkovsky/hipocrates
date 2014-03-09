Hipocrates::Application.routes.draw do

  root to: 'dashboard#index'
  resources :users
  resources :roles, except: :show
  resources :specialities, except: :show

  get 'patients', to: 'users#patients'
  get 'stuff', to: 'users#stuff'

end
