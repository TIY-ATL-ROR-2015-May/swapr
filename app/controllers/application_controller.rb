class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    token = request.headers['Access-Token']
    token && User.find_by(access_token: token)
  end

  def authenticate_with_token!
    unless current_user
      render json: { message: "Access Token not found." },
        status: :unauthorized
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    logger.errors "Shit went all sideways"

    render json: { message: "Could not find the requested object." },
      status: :not_found
  end
end
