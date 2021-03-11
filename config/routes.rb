Rails.application.routes.draw do
  mount_devise_token_auth_for 'Admin', at: 'api/admin_auth'
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    resources :articles, only: %i[index show]

    namespace :admin do
      resources :articles, only: %i[index create update]
    end
  end
end
