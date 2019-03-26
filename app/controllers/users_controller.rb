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

  def index
    channel_with_prefix = 'chat-back_development:action_cable'
    Redis.new.pubsub('channels', "#{channel_with_prefix}*")
    online_ids = Redis.new.pubsub('channels', "#{channel_with_prefix}*").map { |c| c.match(%r{#{channel_with_prefix}/(.*)})[1] }
    # User.in(id: online_ids).map(&:username)

    users = User.all.map do |user|
      { username: user.username, online: online_ids.include?(user.id.to_s) }
    end

    render json: users
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
