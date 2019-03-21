# frozen_string_literal: true

class MessageToMentionedsJob < ApplicationJob
  queue_as :default

  def perform(options)
    username = options[:username]
    roomname = options[:roomname]

    # mentions on message less message owner
    mentioneds = options[:content].scan(/@(\w+)/).flatten
    mentioneds.delete(username)

    User.in(username: mentioneds).map do |user|
      ActionCable.server.broadcast(
        "room_user_#{user.username}",
        "@#{username} te ha mencionado en la sala ##{roomname}"
      )
    end
  end
end
