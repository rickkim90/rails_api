class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  def authenticate
    payload = JsonWebToken.decode(auth_token)
    puts payload.first["sub"]
    @current_user = User.find(payload.first["sub"])
  rescue JWT::DecodeError
    render json: {errors: ["Invalid Token Error"]}, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch("Authorization", "")
  end
end
