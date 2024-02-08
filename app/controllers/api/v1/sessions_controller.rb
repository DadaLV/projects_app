class Api::V1::SessionsController < ApplicationController

  def create
    email = params[:email]
    password = params[:password]
  
    user = User.find_for_database_authentication(email: email)
  
    if user && user.valid_password?(password)
      token = user.authentication_token
      response.headers['Authorization'] = "Bearer #{token}"
      render json: {
        message: "Logged in successfully",
        auth_token: token
      }, status: :ok
    else
      render json: {
        message: "Invalid email or password"
      }, status: :unauthorized
    end
  end

  def destroy
    token = request.headers['Authorization']&.split(' ')&.last
    user = User.find_by(authentication_token: token)
  
    if user
      user.update(authentication_token: nil)
      render json: { message: "Signed out successfully" }, status: :ok
    else
      render json: { message: "User not authenticated" }, status: :unauthorized
    end
  end  
end
