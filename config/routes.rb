Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    resources :stocks, only: [:index]
    resources :news, only: [:index]
  end 
end
