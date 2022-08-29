class HealthCheckController < ApplicationController
  def index
    render json: { message: 'API Health Check OK' }, status: :ok
  end
end
