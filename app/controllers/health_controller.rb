class HealthController < ApplicationController
  def health
    render status: 200
  end
end
