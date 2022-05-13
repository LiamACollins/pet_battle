Rails.application.routes.draw do
  root 'contests#index'
  resources :contests, only: [:show, :create]
  match '/contests' => 'contests#create', via: :post

end
