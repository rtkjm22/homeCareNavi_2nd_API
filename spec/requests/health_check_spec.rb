require 'rails_helper'

RSpec.describe 'HealthCheck' do
  describe 'GET /health_check' do
    it 'response 200' do
      get health_check_path
      assert_response_schema_confirm(200)
    end
  end
end
