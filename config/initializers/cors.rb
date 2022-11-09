# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.production?
      origins ENV['CORS_URL']
    else
      origins 'http://localhost:8080', 'https://rahhi555.stoplight.io'
    end

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      # 認証に必要なヘッダーをホワイトリストに追加
      # https://devise-token-auth.gitbook.io/devise-token-auth/config/cors
      expose: %w[access-token expiry token-type uid client]
  end
end
