require 'silencer/rails/logger'

# AWSのログがヘルスチェックで埋まるため、ヘルスチェックのみログを出力しない
Rails.application.configure do
  config.middleware.swap(
    Rails::Rack::Logger,
    Silencer::Logger,
    config.log_tags,
    silence: ['/health_check']
  )
end
