class SessionsController < ApplicationController
  def create
    if @user = User.authenticate(session_params[:username], session_params[:password])
      render json: @user, status: :created
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    head :ok
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
