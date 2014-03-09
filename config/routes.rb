Hipocrates::Application.routes.draw do

  root to: 'dashboard#index'
  resources :users
  resources :roles, except: :show
  resources :specialities, except: :show

end
