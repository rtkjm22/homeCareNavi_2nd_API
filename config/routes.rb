Rails.application.routes.draw do
  # ヘルスチェック
  get '/health_check', to: 'health_check#index'
end
