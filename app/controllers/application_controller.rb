class ApplicationController < ActionController::Base
  def render_base_response(response)
    if response.present?
      render json: response
    else
      head :not_found
    end
  end
end
