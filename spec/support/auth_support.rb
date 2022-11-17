# frozen_string_literal: true

# ログイン状態を再現する
# @see https://qiita.com/kk-icare/items/20a180f7209ed8f4c485
module AuthSupport
  HTTP_HELPERS_TO_OVERRIDE = %i[get post patch put delete].freeze

  HTTP_HELPERS_TO_OVERRIDE.each do |helper|
    define_method(helper) do |path, **args|
      add_auth_headers(args)
      args == {} ? super(path) : super(path, **args)
    end
  end

  def login(user)
    @user = user
    @auth_token = @user.create_new_auth_token
  end

  def logout
    @user = nil
    @auth_token = nil
  end

  private

  def add_auth_headers(args)
    return unless defined? @auth_token

    args[:headers] ||= {}
    args[:headers].merge!(@auth_token)
  end
end
