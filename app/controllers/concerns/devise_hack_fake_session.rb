# frozen_string_literal: true

# rails7でapiモード中にsessionを操作するとエラーになる現象の対処
# @see https://blog.furu07yu.com/entry/rails7-devise-token-auth#ActionDispatchRequestSessionDisabledSessionError%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6
module DeviseHackFakeSession
  extend ActiveSupport::Concern

  class FakeSession < Hash
    def enabled?
      false
    end

    def destroy; end
  end

  included do
    before_action :set_fake_session

    private

    def set_fake_session
      return unless Rails.configuration.respond_to?(:api_only)
      return unless Rails.configuration.api_only

      request.env['rack.session'] ||= ::DeviseHackFakeSession::FakeSession.new
    end
  end
end
