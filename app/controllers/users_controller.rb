# frozen_string_literal: true

class UsersController < ApplicationController
  # has_secure_password doesn't wrap password
  wrap_parameters :user, include: %i[username password]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
