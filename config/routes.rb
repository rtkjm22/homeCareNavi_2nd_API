Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/overrides/registrations',
        sessions: 'api/v1/overrides/sessions'
      }

      namespace :manager do
        resource :office, only: [:show, :update]
        resource :office_overview, only: [:show, :update]
        resources :office_images, only: [:create, :update]
        resources :staffs, only: [:index, :create, :update, :destroy]
        resources :office_clients
      end

      namespace :client do
        resources :reserves, only: [:index, :create]
        resources :offices, only: [:show] do
          collection do
            get :area_search
            get :nearest_search
            get :word_search
          end
        end
      end
    end
  end

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # ヘルスチェック
  get '/health_check', to: 'health_check#index'
end
