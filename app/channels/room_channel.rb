# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room]}"

    if params[:room].starts_with?('user_')
      ActionCable.server.broadcast('room_userlist', 'update')
    end
    # room_list
    # room_id
    # room_user_xxx
    # room_userlist
  end

  def unsubscribed
    ActionCable.server.broadcast('room_userlist', 'update') if params[:room].starts_with?('user_')
  end
end
