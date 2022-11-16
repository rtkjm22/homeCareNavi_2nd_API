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
      end

      namespace :client do
      end
    end
  end

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # ヘルスチェック
  get '/health_check', to: 'health_check#index'
end
