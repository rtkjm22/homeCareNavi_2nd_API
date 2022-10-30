# 必須環境変数を確認するためのファイル
# @see https://techracho.bpsinc.jp/hachi8833/2021_05_12/107645

if Rails.env.production?
  %w[
    RAILS_ENV
    RAILS_LOG_TO_STDOUT
    CORS_URL
    DATABASE_NAME
    SERVER_PORT
  ].each do |env_var|
    if !ENV.has_key?(env_var) || ENV[env_var].blank?
      raise <<~EOL
      環境変数が存在しませんでした: #{env_var}
      EOL
    end
  end
end