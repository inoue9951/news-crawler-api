Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    resources :brand_lists, only: [:index]
  end 
end
