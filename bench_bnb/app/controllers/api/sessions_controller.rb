class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login!(@user)
      render '/api/users/show'
    else
      render json: { "authErrors": ["Invalid Credentials"]}, status: 401
    end
  end

  def destroy
    logout!
    if current_user
      render json: {}
    else
      render json: {"authErrors": ["No current user to log out"]}, status: 404
    end
  end

end
