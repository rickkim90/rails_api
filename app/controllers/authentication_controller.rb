class AuthenticationController < ApplicationController
  def login
    u = User.find_by(email: params[:user][:email])
    if u and u.authenticate(params[:user][:password])
      render json: {token: JsonWebToken.encode({sub: u.id})}
    else
      render json: {erros: ["Invalid email or password"]}
    end
  end

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
