require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      get 'trending', to: 'trending#index'
      get 'search/index'
      get 'search/autocomplete'
      get 'timeline/index'
      post 'user_token', to: 'user_token#create'

      resources :follows, only: %i[create destroy]
      resources :tweets, only: %i[index show create update destroy] do
        member do
          post 'like', to: 'likes#create'
          delete 'unlike', to: 'likes#destroy'
        end
      end
      resources :users, only: %i[show create update destroy] do
        member do
          get 'following'
          get 'followers'
          post 'follow', to: 'follows#create'
          delete 'unfollow', to: 'follows#destroy'
        end
        get 'current', on: :collection
      end
    end
  end
end
