Rails.application.routes.draw do
  mount_devise_token_auth_for 'Admin', at: 'api/admin_auth'
  namespace :api do
    resources :articles, only: %i[index show create]
    
    namespace :admin do
      resources :articles, only: %i[index create]
    end
  end
end
