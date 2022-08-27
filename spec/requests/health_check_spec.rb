require 'rails_helper'

RSpec.describe 'HealthCheck', type: :request do
  describe 'GET /health_check' do
    it 'response 200' do
      get health_check_path
      expect(response).to have_http_status(:ok)
    end
  end
end
