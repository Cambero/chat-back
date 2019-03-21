# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room]}"
    # room_list
    # room_id
    # room_user_xxx
  end

  def unsubscribed; end
end
